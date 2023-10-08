//
//  RozkladListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import SwiftUI

struct RozkladListView: View {
   
    @ObservedObject var viewModel: RozkladListViewModel
    
    var body: some View {
        List(viewModel.days, id: \.id) { day in
            Section {
                ForEach(day.lessons) { lesson in
                    RozkladCellView(viewModel: .init(discipline: lesson.disciplineFullName, auditory: lesson.classroom, groupAuditory: lesson.groups))
                }
            } header: {
                Text(day.date)
            }

        }
    }
}

#Preview {
    RozkladListView(viewModel: .init(days: []))
}
