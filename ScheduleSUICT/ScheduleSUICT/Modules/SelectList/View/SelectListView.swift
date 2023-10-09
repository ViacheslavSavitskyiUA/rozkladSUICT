//
//  SelectListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import SwiftUI

struct SelectListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: SelectListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    fillScreen(userType: viewModel.userType)
                }
                .task {
                    await viewModel.fetchFaculties()
                }
                
                Spacer()
                
                Button {
                    viewModel.isShowRozklad.toggle()
                } label: {
                    Text("Далі")
                        .font(.gilroy(.semibold, size: 20))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color.fallGold)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .inactive(!viewModel.isActiveNextButton)
                .padding(.bottom)
            }
            .navigationTitle(viewModel.userType.titleSelectItemsView)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrowshape.backward")
                            .bold()
                            .foregroundStyle(Color.fennelFlower)
                    }
                    .disabled(viewModel.isShowLoader)
                }
            }
            .popUpNavigationView(show: $viewModel.isShowLoader) {
                LoaderView()
            }
            .navigationDestination(isPresented: $viewModel.isShowRozklad) {
                if viewModel.isShowRozklad {
                    ScheduleView(viewModel: viewModel.setupRozkladViewModel())
                }
            }
        }
    }
    
    @ViewBuilder func fillScreen(userType: UserType) -> some View {
        VStack {
            SelectItemView(viewModel: viewModel.facultyViewModel)
            
            switch userType {
            case .student:
                SelectItemView(viewModel: viewModel.courseViewModel)
                SelectItemView(viewModel: viewModel.groupViewModel)
            case .teacher:
                SelectItemView(viewModel: viewModel.chairViewModel)
                SelectItemView(viewModel: viewModel.teacherViewModel)
            case .unowned:
                EmptyView()
            }
        }
    }
}

#Preview {
    SelectListView(viewModel: .init(userType: .student))
}
