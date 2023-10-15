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
        NavigationView {
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
                
                NavigationLink(destination: ScheduleView(viewModel: .init(
                    searchId: viewModel.returnScheduleVMParameters().searchId,
                    type: viewModel.returnScheduleVMParameters().type,
                    title: viewModel.returnScheduleVMParameters().title)),
                               isActive: $viewModel.isShowRozklad) {
                    EmptyView()
                }
            }
            .navigationTitle(viewModel.userType.titleSelectItemsView)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
//            .toolbarBackButton(isActiveButton: viewModel.isShowLoader, completion: {
//                dismiss()
//            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.fennelFlower)
                    }
                    .inactive(viewModel.isShowLoader)
                }
            }
            .popUpNavigationView(show: $viewModel.isShowLoader) {
                LoaderView()
            }
        }
        .navigationBarHidden(true)
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
