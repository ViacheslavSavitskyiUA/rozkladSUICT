//
//  ScheduleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI
import Combine

struct ScheduleView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    @State private var isShareSheetPresented = false
    @State private var isPulsing = false
    @State private var isShowErrorView = false
    
    @State var rozkladListViewModel: RozkladListViewModel = .init(lessons: [], type: .unowned)
    @State var dayCollectionViewModel: DayCollectionViewModel = .init(completion: { _ in })
    
    @State var selectDay: RozkladEntity = .init()
    
    @State private var detailInfo: (LessonEntity, UserType) = (.init(), .auditory)
    @State private var isShowDetailView: Bool = false
    
    let type: UserType
    var searchId: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Color.white
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
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
        }
        .navigationBarHidden(true)
        
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                let center = UNUserNotificationCenter.current()
                center.getPendingNotificationRequests { (notifications) in
                        print("Count: \(notifications.count)")
                        for item in notifications {
                          print(item.trigger)
                        }
                    }
            })
        }
        .sheet(isPresented: $isShareSheetPresented, content: {
            ShareSheetView(activityItems: [activityText()])
        })
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
                DayCollectionView(viewModel: dayCollectionViewModel)
                    .background(Color.white)
                showLessons(!selectDay.isEmpty)
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
                Image(systemName: viewModel.checkReturnSaveImage())
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
//        print("datesString \(datesString)")
        
        var haveDates: [String] = .init()
        var haventDates: [String] = .init()
        
        for d in datesString {
            if viewModel.rozklad.contains(where: { $0.date == d }) {
                haveDates.append(d)
            } else {
                haventDates.append(d)
            }
        }
//        print("haveDates \(haveDates)")
//        print("haventDates \(haventDates)")
        
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
        }
        
        if !isShowErrorView,
           StorageService.readStorageTitle() == viewModel.navigationTitle,
           StorageService.readStorageId() == searchId,
           StorageService.readStorageType() == viewModel.type {
            NotificationService.scheduleNotifications(models: viewModel.rozklad,
                                                      userType: viewModel.type)
        }
    }
    
    @MainActor
    func fetchRozklad() async -> Bool {
        viewModel.isShowLoader = true
        switch type {
        case .student:
            do {
                let models = try await viewModel.network.getRozklad(groupId: searchId,
                                                                    dateStart: viewModel.transformRangeDateString().start,
                                                                    dateEnd: viewModel.transformRangeDateString().end).get()
                isShowErrorView = false
//                print(models)
                await viewModel.transformRozklad(models: models)
                viewModel.askedSaveQuestion()
            } catch {
                isShowErrorView = true
            }
            
        case .teacher:
            do {
                let models = try await viewModel.network.getRozklad(teacherId: searchId,
                                                                    dateStart: viewModel.transformRangeDateString().start,
                                                                    dateEnd: viewModel.transformRangeDateString().end).get()
                isShowErrorView = false
//                print(models)
                await viewModel.transformRozklad(models: models)
                viewModel.askedSaveQuestion()
            } catch {
                isShowErrorView = true
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
