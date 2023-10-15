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
        VStack {
            DayCollectionView(viewModel: viewModel.dayCollectionViewModel)
                .background(Color.white)
            
            RozkladListView(viewModel: viewModel.rozkladListViewModel)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewModel.navigationTitle)
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
            await viewModel.fetchRozklad()
            await viewModel.setupDays()
        }
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .unowned, title: ""))
}
