//
//  ScheduleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI

struct ScheduleView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
            VStack {
                DayCollectionView(viewModel: viewModel.dayCollectionViewModel)
                RozkladListView(viewModel: viewModel.rozkladListViewModel)
            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrowshape.backward")
//                            .bold()
                            .foregroundStyle(Color.fennelFlower)
                    }
                    .disabled(viewModel.isShowLoader)
                }
            }
            .popUpNavigationView(show: $viewModel.isShowLoader, content: {
                LoaderView()
            })
        .task {
            await viewModel.fetchRozklad()
            await viewModel.setupDays()
        }
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .unowned, title: ""))
}
