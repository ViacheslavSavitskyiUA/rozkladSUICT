//
//  RozkladListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import SwiftUI
import Combine

struct RozkladListView: View {
    
    @ObservedObject var viewModel: RozkladListViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(viewModel.lessons) { lesson in
                    RozkladCellView(viewModel: .init(lesson: lesson, type: viewModel.type))
                    .padding(.bottom, 12)
                    .dynamicTypeSize(...DynamicTypeSize.medium)
                }
            }
        }
    }
}

#Preview {
    RozkladListView(viewModel: .init(lessons: [], type: .student))
}
