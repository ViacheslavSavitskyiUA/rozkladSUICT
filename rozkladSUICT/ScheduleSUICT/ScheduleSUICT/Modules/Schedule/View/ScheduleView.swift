//
//  ScheduleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI
import Combine
import EffectsLibrary
import StoreKit

struct ScheduleView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) private var context
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    @State private var isShareSheetPresented = false
    @State private var isShowErrorView = false
    
    @State private var isShowSnakeGame = false
    
    @State private var isHideLights = true
    
    @State private var isShowOfflineText = false
    
    @State var rozkladListViewModel: RozkladListViewModel = .init(lessons: [], type: .unowned)
    @State var dayCollectionViewModel: DayCollectionViewModel = .init(completion: { _ in })
    
    @State var selectDay: RozkladEntity = .init()
    
    @State private var detailInfo: (LessonEntity, UserType) = (.init(), .auditory)
    @State private var isShowDetailView: Bool = false
    
    @State private var swiftDataService = SwiftDataService()
    
    let type: UserType
    var searchId: Int = 0
    
    var body: some View {
        ZStack {
            SnowView()
                .offset(y: -80)
                .opacity(isHideLights ? 0 : 1)
            VStack {
                VStack {
                    ZStack {
                        Color.clear
                        HStack {
                            Button {
                                mode.wrappedValue.dismiss()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
                                    withAnimation {
                                        isHideLights.toggle()
                                    }
                                })
                            } label: {
                                Image("backArrow")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 16)
                            }
                            Spacer()
                        }
                        
                        Text(viewModel.navigationTitle)
                            .font(.system(size: 16))
                            .bold()
                        
                        HStack(spacing: 12) {
                            Spacer()
                            Button {
                                isShareSheetPresented = true
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .padding(.horizontal, type == .auditory ? 16 : 0)
                            }
                            showFavorite(type: type)
                        }
                    }
                    .frame(height: 48)
                    showView(isError: isShowErrorView)
                }
                showOfflineText(isShowOfflineText)
            }
            .navigationBarHidden(true)
            .overlay(content: {
                LottieView(loopMode: .loop,
                                               lottieFile: LottieFile.NewYear.cat.rawValue)
                                    .scaleEffect(0.03)
                                    .scaledToFit()
                                    .offset(x: UIScreen.main.bounds.width / 2 - 54,
                                            y: UIScreen.main.bounds.height / 2 - 32)
            })
            
            .popUpNavigationView(show: $isShowDetailView) {
                RozkladDetailView(lesson: detailInfo.0, type: detailInfo.1, completion: {
                    isShowDetailView = false
                })
            }
            .popUpNavigationView(show: $viewModel.isShowLoader, content: {
                LoaderView()
            })
            .popUpNavigationView(show: $viewModel.isShowSaveAlert, content: {
                SavePopUpView(savePopUpType: viewModel.userDataStatus == .unsaved ? .save : .remove) {
                    viewModel.userDataStatus == .unsaved ? viewModel.saveUserData() : viewModel.unsaveUserData()
                    viewModel.isShowSaveAlert = false
                } cancel: {
                    viewModel.isShowSaveAlert = false
                }
            })
            .task {
                setupViewModels()
                isShowErrorView = await fetchRozklad()
                await setupDays()
                viewModel.checkPush()
                isHideLights = false
                
                
                let randomNumber: Int = .random(in: 1...15)
                print("randomNumber = \(randomNumber)")
                if randomNumber == 4 {
                    guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                          print("UNABLE TO GET CURRENT SCENE")
                          return
                    }
                    SKStoreReviewController.requestReview(in: currentScene)
                }
            }
            .sheet(isPresented: $isShareSheetPresented, content: {
                ShareSheetView(activityItems: [activityText()])
        })
            .overlay(alignment: .bottomTrailing) {

                PJRPulseButton(action: {
                    isShowSnakeGame = true
                })
                .padding([.bottom, .trailing], -12)
                .opacity(viewModel.isShowLoader ? 0 : 1)

        }
            NavigationLink(destination: GameView(), isActive: $isShowSnakeGame) {
                EmptyView()
            }.isDetailLink(false)
        }
    }
    
    @ViewBuilder func showOfflineText(_ isShow: Bool) -> some View {
        if isShow {
            MarqueeText(text: "Увага! Не вдалось встановити зʼєдання з сервером! Розклад може відрізнятись!", font: UIFont.preferredFont(forTextStyle: .subheadline), leftFade: 16, rightFade: 16, startDelay: 1)
        }
    }
    
    @ViewBuilder func showLessons(_ hasLessons: Bool) -> some View {
        switch hasLessons {
        case true:
            RozkladListView(viewModel: rozkladListViewModel, completion: { (lesson, type) in
                detailInfo = (lesson, type)
                withAnimation {
                    isShowDetailView = true
                }
            })
        case false:
            EmptyLessonsView()
        }
    }
    
    @ViewBuilder func showView(isError: Bool) -> some View {
        switch isError {
        case true:
            NetworkErrorView()
        case false:
            VStack {
                LottieView(loopMode: .loop, lottieFile: LottieFile.NewYear.light.rawValue)
                    .scaleEffect(0.2)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 8)
                    .opacity(isHideLights ? 0 : 1)
                DayCollectionView(viewModel: dayCollectionViewModel)
                showLessons(!selectDay.isEmpty)
                    .opacity(viewModel.isShowLoader ? 0 : 1)
            }
        }
    }
    
    @ViewBuilder func showFavorite(type: UserType) -> some View {
        switch type {
        case .student, .teacher:
            Button {
                withAnimation {
                    viewModel.isShowSaveAlert = true
                }
            } label: {
                Image(systemName: viewModel.saveImageFlag ? "star.fill" : "star" )
            }
            .frame(width: 24, height: 24)
            .padding(.trailing, 16)
            .opacity(isShowErrorView ? 0 : 1)
        default: EmptyView()
        }
    }
    
    private func setupViewModels() {
        rozkladListViewModel = .init(lessons: [], type: type)
        
        dayCollectionViewModel = .init(completion: { rozklad in
            withAnimation(.easeIn) {
                self.selectDay = rozklad
                self.rozkladListViewModel.lessons = rozklad.lessons
                self.dayCollectionViewModel.day = rozklad
            }
        })
        
        if StorageService.readStorageId() == searchId
            && StorageService.readStorageType() == type
            && StorageService.readStorageTitle() == viewModel.navigationTitle {
            viewModel.userDataStatus = .saved
        } else {
            viewModel.userDataStatus = .unsaved
        }
    }
    
    func activityText() -> String {
        var text = ""
        
        if selectDay.lessons.count == 0 {
            text = "\(viewModel.navigationTitle)\n\(Transform.transformDateToString(date: Transform.transformStringToDate(selectDay.date, dateFormat: .yyyyMMdd), dateFormat: .ddMMyyyy))\nнемає занять"
        } else {
            text = "\(viewModel.navigationTitle)\n\(Transform.transformDateToString(date: Transform.transformStringToDate(selectDay.date, dateFormat: .yyyyMMdd), dateFormat: .ddMMyyyy))\n\n"
            
            for lesson in selectDay.lessons {
                text.append("\(lesson.lessonNumber) пара \(lesson.timeStart)-\(lesson.timeEnd)")
                text.append("\n")
                text.append(lesson.disciplineShortName)
                text.append("[\(lesson.typeStr)]")
                text.append("\n")
                
                switch type {
                case .student:
                    text.append(lesson.teachersName)
                    text.append("\n")
                    text.append("\(lesson.classroom) ауд.")
                case .teacher:
                    text.append(lesson.groups)
                    text.append("\n")
                    text.append("\(lesson.classroom) ауд.")
                case .auditory:
                    text.append(lesson.groups)
                    text.append("\n")
                    text.append(lesson.teachersName)
                case .unowned: ()
                case .hero: ()
                }
                
                text.append("\n\n")
            }
        }
        
        return text
    }
    
    @MainActor
    func setupDays() async {
        let dates = Date().getCurrentWeekDays()
        
        var datesString = [String]()
        var rozkladObject: RozkladEntity = .init()
        
        for date in dates {
            datesString.append(Transform
                .transformDateToString(date: date,
                                       dateFormat: .yyyyMMdd))
        }
    
        var haveDates: [String] = .init()
        var haventDates: [String] = .init()
        
        for d in datesString {
            if viewModel.rozklad.contains(where: { $0.date == d }) {
                haveDates.append(d)
            } else {
                haventDates.append(d)
            }
        }
        
        for date in datesString {
            for r in viewModel.rozklad {
                if date == r.date && haveDates.contains(r.date) {
                    rozkladObject.date = date
                    rozkladObject.dayWeek = Transform.transformDateToString(date: Transform.transformStringToDate(date, dateFormat: .yyyyMMdd), dateFormat: .eeee)
                    rozkladObject.isToday = Calendar.current.isDateInToday(Transform.transformStringToDate(date, dateFormat: .yyyyMMdd))
                    rozkladObject.isSelected = rozkladObject.isToday
                    
                    for lesson in r.lessons {
                        rozkladObject.lessons.append(
                            .init(lessonNumber: lesson.lessonNumber,
                                  disciplineFullName: lesson.disciplineFullName,
                                  disciplineShortName: lesson.disciplineShortName,
                                  classroom: lesson.classroom,
                                  timeStart: lesson.timeStart,
                                  timeEnd: lesson.timeEnd,
                                  teachersName: lesson.teachersName,
                                  teachersNameFull: lesson.teachersNameFull,
                                  groups: lesson.groups,
                                  type: lesson.type,
                                  typeStr: lesson.typeStr))
                    }
                    
                    if rozkladObject.isToday {
                        withAnimation(.easeIn) {
                            selectDay = rozkladObject
                            dayCollectionViewModel.day = rozkladObject
                            rozkladListViewModel.lessons = rozkladObject.lessons
                        }
                    }
                    
                } else if haventDates.contains(date) {
                    rozkladObject.date = date
                    rozkladObject.dayWeek = Transform
                        .transformDateToString(date:
                                                Transform.transformStringToDate(date,
                                                                                dateFormat: .yyyyMMdd),
                                               dateFormat: .eeee)
                    rozkladObject.isEmpty = true
                    rozkladObject.lessons = []
                    rozkladObject.isToday = Calendar.current.isDateInToday(Transform.transformStringToDate(date, dateFormat: .yyyyMMdd))
                    rozkladObject.isSelected = rozkladObject.isToday
                    
                    if rozkladObject.isToday {
                        withAnimation(.easeIn) {
                            selectDay = rozkladObject
                            dayCollectionViewModel.day = rozkladObject
                            rozkladListViewModel.lessons = rozkladObject.lessons
                        }
                    }
                }
            }
            dayCollectionViewModel.days.append(rozkladObject)
            rozkladObject = .init()
            
            if haveDates.isEmpty {
                rozkladObject.date = date
                rozkladObject.dayWeek = Transform
                    .transformDateToString(date:
                                            Transform.transformStringToDate(date,
                                                                            dateFormat: .yyyyMMdd),
                                           dateFormat: .eeee)
                rozkladObject.isEmpty = true
                rozkladObject.lessons = []
                rozkladObject.isToday = Calendar.current.isDateInToday(Transform.transformStringToDate(date, dateFormat: .yyyyMMdd))
                rozkladObject.isSelected = rozkladObject.isToday
                
                if rozkladObject.isToday {
                    withAnimation(.easeIn) {
                        selectDay = rozkladObject
                        dayCollectionViewModel.day = rozkladObject
                        rozkladListViewModel.lessons = rozkladObject.lessons
                    }
                }
            }
        }
        
        if !isShowErrorView,
           StorageService.readStorageTitle() == viewModel.navigationTitle,
           StorageService.readStorageId() == searchId,
           StorageService.readStorageType() == viewModel.type {
            viewModel.notificationService.scheduleNotifications(models: viewModel.rozklad,
                                                                userType: viewModel.type)
            viewModel.checkReturnSaveImage()
        }
        
        viewModel.checkPush()
    }
    
    @MainActor
    func fetchRozklad() async -> Bool {
        viewModel.rozklad = []
        viewModel.isShowLoader = true
        switch type {
        case .student:
            do {
                let models = try await viewModel.network.getRozklad(groupId: searchId,
                                                                    dateStart: viewModel.transformRangeDateString().start,
                                                                    dateEnd: viewModel.transformRangeDateString().end).get()
                isShowErrorView = false
                await viewModel.transformRozklad(models: models)
                viewModel.askedSaveQuestion()
                
                if StorageService.readStorageTitle() != nil,
                   viewModel.userDataStatus == .saved {
                    swiftDataService.saveRozklad(schedule: models, context: context)
                }
                isShowOfflineText = false
            } catch {
                if viewModel.getRozkladEqualNavTitle() {
                    await viewModel.transformRozklad(models: swiftDataService.fetchRozklad(context: context))
                    isShowOfflineText = true
                } else {
                    isShowErrorView = true
                }
            }
            
        case .teacher:
            do {
                let models = try await viewModel.network.getRozklad(teacherId: searchId,
                                                                    dateStart: viewModel.transformRangeDateString().start,
                                                                    dateEnd: viewModel.transformRangeDateString().end).get()
                isShowErrorView = false
                await viewModel.transformRozklad(models: models)
                viewModel.askedSaveQuestion()
                
                if StorageService.readStorageTitle() != nil {
                    swiftDataService.saveRozklad(schedule: models, context: context)
                }
                isShowOfflineText = false
            } catch {
                if viewModel.getRozkladEqualNavTitle(),
                    viewModel.userDataStatus == .saved {
                    await viewModel.transformRozklad(models: swiftDataService.fetchRozklad(context: context))
                    isShowOfflineText = true
                } else {
                    isShowErrorView = true
                }
            }
        case .auditory:
            do {
                let models = try await viewModel.network.getRozklad(classroomId: searchId,
                                                                    dateStart: viewModel.transformRangeDateString().start,
                                                                    dateEnd: viewModel.transformRangeDateString().end).get()
                isShowErrorView = false
                await viewModel.transformRozklad(models: models)
            } catch {
                isShowErrorView = true
            }
        default: ()
        }
        viewModel.isShowLoader = false
        return isShowErrorView
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .student, title: "zamriy"), type: .auditory, searchId: 1)
}
