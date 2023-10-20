//
//  ChoiceView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

struct ChoiceView: View {
    
    @ObservedObject var viewModel: ChoiceViewModel
    
    var body: some View {
        NavigationView {

            ZStack {
                
                VStack {
                    Text("Оберіть розклад, що Вас цікавить")
                        .font(.gilroy(.semibold, size: 18))
                        .padding(.horizontal)
                        .padding(.bottom, UIScreen.main.bounds.size.width / 2 + 200)
                }
                
                VStack(spacing: 0) {
                    
                    Group {
                        HStack {
                            ChoiceCardView(viewModel: viewModel.studentCardViewModel,
                                           userType: .student)
                            .onTapGesture {
                                viewModel.select(userType: .student)
                            }
                            
                            Spacer().frame(width: 20)
                            
                            ChoiceCardView(viewModel: viewModel.studentCardViewModel, userType: .auditory)
                        }
                        Spacer().frame(height: 20)
                        
                        HStack {
                            ChoiceCardView(viewModel: viewModel.teacherCardViewModel,
                                           userType: .teacher)
                            .onTapGesture {
                                viewModel.select(userType: .teacher)
                            }
                            
                            Spacer().frame(width: 20)
                            
                            ChoiceCardView(viewModel: viewModel.teacherCardViewModel, userType: .freeAuditory)
                        }
                    }
                }
            }
            
            NavigationLink(destination: SelectListView(viewModel: .init(userType: viewModel.selectUserType)),
                           isActive: $viewModel.isToNextScreen) {
                EmptyView()
            }
        }
        Spacer()
        
        Button {
            viewModel.isToNextScreen.toggle()
        } label: {
            Text("Далі")
                .font(.gilroy(.semibold, size: 20))
                .padding()
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(Color.fallGold)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .inactive(viewModel.selectUserType != .unowned ? false : true)
        .padding(.bottom)
        
        NavigationLink(destination: ScheduleView(viewModel: .init(searchId: StorageService.readStorageId() ?? 0,
                                                                  type: StorageService.readStorageType() ?? .unowned,
                                                                  title: StorageService.readStorageTitle() ?? "")),
                       isActive: $viewModel.isToScheduleScreen) {
            EmptyView()
        }
                       .navigationBarHidden(true)
        //    }
        
        //        }
                       .task {
                           viewModel.showSchedule()
                       }
                       .onAppear {
                           viewModel.isToScheduleScreen = false
                       }
                       .navigationViewStyle(.stack)
    }
}

#Preview {
    ChoiceView(viewModel: .init())
}
