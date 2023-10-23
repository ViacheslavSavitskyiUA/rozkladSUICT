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
                                ChoiceCardView(viewModel: viewModel.auditoryCardViewModel, userType: .auditory)
                                    .onTapGesture {
                                        viewModel.select(userType: .auditory)
                                    }
                            }
                            Spacer().frame(height: 20)
                            
                            HStack {
                                ChoiceCardView(viewModel: viewModel.studentCardViewModel,
                                               userType: .student)
                                .onTapGesture {
                                    viewModel.select(userType: .student)
                                }
                                
                                Spacer().frame(width: 20)
                                
                                ChoiceCardView(viewModel: viewModel.teacherCardViewModel,
                                               userType: .teacher)
                                .onTapGesture {
                                    viewModel.select(userType: .teacher)
                                }
                            }
                            
                        }

                    Spacer()
                    
                    Button {
                        viewModel.isToNextMain = true
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
                }
                
                NavigationLink(destination: SelectListView(viewModel: .init(userType: viewModel.selectUserType)),
                               isActive: $viewModel.isToNextScreen) {
                    EmptyView()
                }
                
                NavigationLink(destination: SelectAuditoryListView(viewModel: .init(title: viewModel.selectUserType.titleSelectItemsView)),
                               isActive: $viewModel.isToNextScreenAuditory) {
                    EmptyView()
                }
            }
            .padding(.bottom)
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .task {
                viewModel.showSchedule()
            }
            .onAppear {
                viewModel.isToScheduleScreen = false
            }
            .navigationViewStyle(.stack)
        }
        
        NavigationLink(destination: ScheduleView(viewModel: .init(searchId: StorageService.readStorageId() ?? 0,
                                                                  type: StorageService.readStorageType() ?? .unowned,
                                                                  title: StorageService.readStorageTitle() ?? "")),
                       isActive: $viewModel.isToScheduleScreen) {
            EmptyView()
        }
    }
}

#Preview {
    ChoiceView(viewModel: .init())
}
