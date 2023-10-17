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
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        showView(isError: viewModel.isShowErrorView)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarHidden(viewModel.isShowLoader)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        mode.wrappedValue.dismiss()
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
            .popUpNavigationView(show: $viewModel.isShowLoader, content: {
                LoaderView()
            })
            .task {
                viewModel.setupView()
            }
    }
    
    @ViewBuilder func showLessons(_ hasLessons: Bool) -> some View {
        switch hasLessons {
        case true:
            RozkladListView(viewModel: viewModel.rozkladListViewModel)
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
                DayCollectionView(viewModel: viewModel.dayCollectionViewModel)
                    .background(Color.white)
                
                showLessons(!viewModel.selectDay.isEmpty)
            }
        }
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .unowned, title: ""))
}
