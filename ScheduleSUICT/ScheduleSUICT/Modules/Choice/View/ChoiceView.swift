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
            VStack(spacing: 20) {
                
                Spacer()
                Spacer()
                
                Group {
                    ChoiceCardView(viewModel: viewModel.studentCardViewModel,
                                   userType: .student)
                        .onTapGesture {
                            viewModel.select(userType: .student)
                        }
                    
                    Text("Оберіть свою сторону")
                        .font(.gilroy(.semibold,
                                      size: 24))
                        .padding()
                    
                    ChoiceCardView(viewModel: viewModel.teacherCardViewModel,
                                   userType: .teacher)
                        .onTapGesture {
                            viewModel.select(userType: .teacher)
                        }
                }
                
                Spacer()
                
                Button {
                    print("tap")
                } label: {
                    Text("Далі")
                        .font(.gilroy(.semibold, size: 20))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color.fallGold)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(viewModel.selectUserType != .unowned ? false : true)
                .opacity(viewModel.selectUserType != .unowned ? 1 : 0.5)
                .padding(.bottom)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    ChoiceView(viewModel: .init())
}
