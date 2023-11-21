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
    
    @State var selectUserType: UserType = .unowned
    
    @State var isToNextScreen = false
    @State var isToNextScreenAuditory = false
    @State var isToNextScreenFreeAuditory = false
    
    @State var isToNextMain = false {
        didSet {
            if selectUserType == .student || selectUserType == .teacher {
                isToNextScreen = true
                isToNextScreenAuditory = false
            } else if selectUserType == .auditory {
                isToNextScreen = false
                isToNextScreenAuditory = true
                isToNextScreenFreeAuditory = false
            } else {
                isToNextScreen = false
                isToNextScreenAuditory = false
                isToNextScreenFreeAuditory = false
            }
        }
    }
    
    @State var isToScheduleScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    Text("Оберіть розклад, що Вас цікавить")
                        .font(.gilroy(.semibold, size: 17))
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    
                    Spacer().frame(height: 8)
                    
                    Group {
                        
                        HStack {
                            ChoiceCardView(viewModel: auditoryCardViewModel, userType: .auditory)
                                .onTapGesture {
                                    select(userType: .auditory)
                                }
                        }
                        Spacer().frame(height: 20)
                        
                        HStack {
                            ChoiceCardView(viewModel: studentCardViewModel,
                                           userType: .student)
                            .onTapGesture {
                                select(userType: .student)
                            }
                            
                            Spacer().frame(width: 16)
                            
                            ChoiceCardView(viewModel: teacherCardViewModel,
                                           userType: .teacher)
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
                    }
                }
                
                NavigationLink(destination: SelectAuditoryListView(viewModel: .init(title: selectUserType.titleSelectItemsView)),
                               isActive: $isToNextScreenAuditory) {
                    EmptyView()
                }.isDetailLink(false)
            }
            .padding(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .task {
                showSchedule()
            }
            .navigationViewStyle(.stack)
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
            case .teacher:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = true
                auditoryCardViewModel.isSelect = false
            case .unowned: ()
            case .auditory:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = false
                auditoryCardViewModel.isSelect = true
            }
        }
    }
}

//#Preview {
//    ChoiceView(viewModel: .init())
//}
