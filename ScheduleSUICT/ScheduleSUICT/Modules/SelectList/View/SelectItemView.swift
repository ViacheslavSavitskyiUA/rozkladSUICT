//
//  SelectItemView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import SwiftUI

struct SelectItemView: View {
    
    @ObservedObject var viewModel: SelectItemViewModel
    
    var body: some View {
        DisclosureGroup(isExpanded: $viewModel.isReveal,
                        content: {
                VStack(spacing: 16) {
                    ForEach(viewModel.inputsData) { item in
                        VStack {
                            Divider()
                            Text("(\(item.shortName)) \(item.fullName)")
                                .font(.gilroy(.regular, size: 14))
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectedItem = item
                                        viewModel.isReveal.toggle()
                                    }
                                    
                                }
                                .padding(.top)
                        }
                    }
                }
        }, label: {
            Text(viewModel.selectedItem == nil 
                 ? "Оберіть інститут"
                 : "(\(viewModel.selectedItem?.shortName ?? ""))\(viewModel.selectedItem?.fullName ?? "")")
                .foregroundStyle(Color.black)
                .font(.gilroy(.bold, size: 16))
        })
    }
}

#Preview {
    SelectItemView(viewModel: .init(inputsData: [], type: .faculty))
}
