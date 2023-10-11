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
            .margin(edges: .horizontal, 16)
        }
        .frame(height: 100)
    }
}

#Preview {
    DayCollectionView(viewModel: .init())
}
