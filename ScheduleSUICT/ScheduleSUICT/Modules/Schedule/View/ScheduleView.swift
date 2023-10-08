//
//  ScheduleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                DayCollectionView(viewModel: .init())
                    
                RozkladListView(viewModel: viewModel.rozkladListViewModel)
            }
            .navigationTitle("Schedule")
            .navigationBarTitleDisplayMode(.large)
//            .navigationBarBackButtonHidden(true)
        }
        .task {
            await viewModel.fetchRozklad()
        }
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .unowned))
}
