//
//  DayCollectionView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI
import Combine

struct DayCollectionView: View {
    
    private let dayColumns: [GridItem] = [GridItem(.fixed(60))]
    
    @ObservedObject var viewModel: DayCollectionViewModel
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: dayColumns) {
                    ForEach(viewModel.days) { day in
                        DayCellView(viewModel: .init(day: day),
                                    selected: { day in
                            withAnimation(.easeIn) {
                                viewModel.selected(day: day)
                            }
                            viewModel.completion(day)
                        })
                    }
                }
            }
            .margin(edges: .horizontal, 16)
            .onReceive(Just(viewModel.day), perform: { _ in
                withAnimation(.easeIn) {
                        value.scrollTo(viewModel.day.id, anchor: .center)
                }
            })
        }
        .frame(height: 60)
    }
}

//#Preview {
//    DayCollectionView(viewModel: .init())
//}
