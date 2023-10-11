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
        NavigationView { //////
            VStack {
                ScrollView {
                    VStack(spacing: 14) {
                        
                        Spacer()
                        
                        Group {
                            ChoiceCardView(viewModel: viewModel.studentCardViewModel,
                                           userType: .student)
                            .onTapGesture {
                                viewModel.select(userType: .student)
                            }
                            
                            Text("Оберіть свою сторону")
                                .font(.gilroy(.bold, size: 24))
                                .padding()
                            
                            ChoiceCardView(viewModel: viewModel.teacherCardViewModel,
                                           userType: .teacher)
                            .onTapGesture {
                                viewModel.select(userType: .teacher)
                            }
                        }
                        .padding(.top, 16)
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
            }
        }.navigationViewStyle(.stack)
            
//        .scrollIndicators(.hidden)
    }
}

#Preview {
    ChoiceView(viewModel: .init())
}
