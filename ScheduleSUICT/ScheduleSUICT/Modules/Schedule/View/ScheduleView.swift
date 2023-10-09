//
//  ScheduleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI

struct ScheduleView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
//        NavigationView {
            VStack {
                DayCollectionView(viewModel: viewModel.dayCollectionViewModel)
                RozkladListView(viewModel: viewModel.rozkladListViewModel)
            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
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
            .popUpNavigationView(show: $viewModel.isShowLoader, content: {
                LoaderView()
            })
//            .navigationBarHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
//        }
        .task {
            await viewModel.fetchRozklad()
        }
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .unowned, title: ""))
}
