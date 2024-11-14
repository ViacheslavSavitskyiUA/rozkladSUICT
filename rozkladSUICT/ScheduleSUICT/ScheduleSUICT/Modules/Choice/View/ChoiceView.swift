//
//  ChoiceView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

struct ChoiceView: View {
    
    @ObservedObject var viewModel: ChoiceViewModel
    
    @State var studentCardViewModel: ChoiceCardViewModel = .init()
    @State var teacherCardViewModel: ChoiceCardViewModel = .init()
    @State var auditoryCardViewModel: ChoiceCardViewModel = .init()
    @State var heroCardViewModel: ChoiceCardViewModel = .init()
    
    @State var selectUserType: UserType = .unowned
    
    @State var isToNextScreen = false
    @State var isToNextScreenAuditory = false
    @State var isToNextScreenFreeAuditory = false
    @State var isShowLinks = false
    @State var isToNextScreenHero = false
    
    @State var isToNextMain = false {
        didSet {
            if selectUserType == .student || selectUserType == .teacher {
                isToNextScreen = true
                isToNextScreenAuditory = false
                isToNextScreenHero = false
            } else if selectUserType == .auditory {
                isToNextScreen = false
                isToNextScreenAuditory = true
                isToNextScreenFreeAuditory = false
                isToNextScreenHero = false
            } else if selectUserType == .hero {
                isToNextScreen = false
                isToNextScreenHero = false
                isToNextScreenFreeAuditory = false
                isToNextScreenHero = true
            } else {
                isToNextScreen = false
                isToNextScreenAuditory = false
                isToNextScreenFreeAuditory = false
                isToNextScreenHero = false
            }
        }
    }
    
    @State var isToScheduleScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    isShowLinks = true
                } label: {
                    Image("logoIPZ")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding(.top, 16)
                }

                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    Text("Оберіть, що Вас цікавить")
                        .font(.gilroy(.semibold, size: 17))
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    
                    Spacer().frame(height: 8)
                    
                    Group {
                        
                        HStack {
                            ChoiceCardView(viewModel: auditoryCardViewModel, userType: .auditory, isHero: false)
                                .onTapGesture {
                                    select(userType: .auditory)
                                }
                            
                            Spacer().frame(width: 16)
                            
                            ChoiceCardView(viewModel: heroCardViewModel, userType: .hero, isHero: true)
                                .onTapGesture {
                                    select(userType: .hero)
                                }
                            
                        }
                        Spacer().frame(height: 20)
                        
                        HStack {
                            ChoiceCardView(viewModel: studentCardViewModel,
                                           userType: .student, isHero: false)
                            .onTapGesture {
                                select(userType: .student)
                            }
                            
                            Spacer().frame(width: 16)
                            
                            ChoiceCardView(viewModel: teacherCardViewModel,
                                           userType: .teacher, isHero: false)
                            .onTapGesture {
                                select(userType: .teacher)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        isToNextMain = true
//                        fatalError("Crash was triggered")
                    } label: {
                        Text("Далі")
                            .font(.gilroy(.semibold, size: 20))
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .background(Color.fallGold)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .inactive(selectUserType != .unowned ? false : true)
                    
                    NavigationLink(destination: SelectListView(viewModel: .init(userType: selectUserType)),
                                   isActive: $isToNextScreen) {
                        EmptyView()
                    }.isDetailLink(false)
                    
                    NavigationLink(destination: ScheduleView(viewModel: .init(searchId: StorageService.readStorageId() ?? 0,
                                                                              type: StorageService.readStorageType() ?? .unowned,
                                                                              title: StorageService.readStorageTitle() ?? ""),
                                                             type: StorageService.readStorageType() ?? .unowned,
                                                             searchId: StorageService.readStorageId() ?? 0),
                                   isActive: $isToScheduleScreen) {
                        EmptyView()
                    }.isDetailLink(false)
                }
                
                NavigationLink(destination: SelectAuditoryListView(viewModel: .init(title: selectUserType.titleSelectItemsView)),
                               isActive: $isToNextScreenAuditory) {
                    EmptyView()
                }.isDetailLink(false)
                
                NavigationLink(destination: HeroView(), isActive: $isToNextScreenHero) {
                    EmptyView()
                }.isDetailLink(false)
            }
            .padding(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .task {
                UIApplication.shared.applicationIconBadgeNumber = 0
                showSchedule()
            }
            .navigationViewStyle(.stack)
        }
        .sheet(isPresented: $isShowLinks) {
            print("Sheet dismissed!")
        } content: {
            if #available(iOS 16.0, *) {
                ChoiceLinksView {
                    isShowLinks = false
                }
                .presentationDetents([.height(240)])
            } else {
                ChoiceLinksView {
                    isShowLinks = false
                }
            }
        }
    }
    
    func showSchedule() {
        guard (StorageService.readStorageId() != nil),
              (StorageService.readStorageType() != nil),
              (StorageService.readStorageTitle() != nil) else {
            return
        }
        isToScheduleScreen = true
    }
    
    func select(userType: UserType) {
        withAnimation(.easeInOut) {

            self.selectUserType = userType
            
            switch userType {
            case .student:
                studentCardViewModel.isSelect = true
                teacherCardViewModel.isSelect = false
                auditoryCardViewModel.isSelect = false
                heroCardViewModel.isSelect = false
            case .teacher:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = true
                auditoryCardViewModel.isSelect = false
                heroCardViewModel.isSelect = false
            case .unowned: ()
            case .auditory:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = false
                auditoryCardViewModel.isSelect = true
                heroCardViewModel.isSelect = false
            case .hero:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = false
                auditoryCardViewModel.isSelect = false
                heroCardViewModel.isSelect = true
            }
        }
    }
}

#Preview {
    ChoiceView(viewModel: .init())
}
