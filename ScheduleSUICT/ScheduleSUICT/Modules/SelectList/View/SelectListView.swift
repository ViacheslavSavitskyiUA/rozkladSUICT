//
//  SelectListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import SwiftUI

struct SelectListView: View {
    
    @ObservedObject var viewModel: SelectListViewModel
    
    var body: some View {
            VStack {
                ScrollView {
                    GroupBox {
                        VStack(spacing: 20) {
                            SelectItemView(viewModel: viewModel.facultyViewModel)
                        }
                    }
                    .background(Color.pastelBianca)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding()
                }
                .task {
                    do {
                        try await viewModel.fetchFaculties()
                    } catch {
                        print(error)
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
                .disabled(false)
                .opacity(1)
                .padding(.bottom)
            }
            .navigationTitle(viewModel.userType.titleSelectItemsView)
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SelectListView(viewModel: .init(userType: .student))
}
