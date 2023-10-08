//
//  DayCollectionView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI

struct DayCollectionView: View {
    
    private let dayColumns: [GridItem] = [GridItem(.fixed(54))]
    
    @ObservedObject var viewModel: DayCollectionViewModel
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: dayColumns) {
                    ForEach(viewModel.days) { day in
                        DayCellView(viewModel: .init(day: day),
                                    selected: { day in
                            withAnimation {
                                viewModel.selected(day: day)
                            }
                        })
                    }
                }
            }
            .padding(.top, 8)
            .task {
                do {
                   // try await viewModel.fetchLoses()
                    try await viewModel.fetchDays()
                    withAnimation(.easeIn) {
                      //  value.scrollTo(viewModel.equipmentEntities[viewModel.equipmentEntities.count - 1].id)
                    }
                } catch {
                    print(error)
                }
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    DayCollectionView(viewModel: .init())
}