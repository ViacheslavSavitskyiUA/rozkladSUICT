//
//  SelectTeacherView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 25.10.2023.
//

import SwiftUI

struct SelectTeacherView: View {
    
    @ObservedObject var viewModel: SelectTeacherViewModel
    
    @FocusState private var isFocusState: Bool
    
    var body: some View {
        GroupBox {
            DisclosureGroup(isExpanded: $viewModel.isOpen,
                            content: {
                VStack(spacing: 16) {
                    ForEach(viewModel.teachers) { item in
                        VStack {
                            Divider()
                            Text(viewModel.setupItemTitle(item))
                                .font(.gilroy(.regular, size: 14))
                                .padding(.top)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectedItem = item
                                        viewModel.searchText = viewModel.setupItemTitle(item)
                                        viewModel.isOpen = false
                                        isFocusState = false
                                    }
                                }
                        }
                    }
                }
            }, label: {
                TextField("Введіть прізвище", text: $viewModel.searchText)
                    .foregroundStyle(Color.black)
                    .font(.gilroy(.bold, size: 16))
                    .focused($isFocusState)
                    .modifier(TextFieldClearButton(text: $viewModel.searchText))
                    .onChange(of: viewModel.searchText) { value in
                        Task {
                            if !value.isEmpty && value.count > 0 {
                                await viewModel.search(teachers: value)
                            } else {
                                viewModel.teachers.removeAll()
                            }
                        }
                    }
                    .padding(.all, 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.fallGold.opacity(0.25), lineWidth: 2)
                    )
            })
        }
        .background(Color.pastelBianca)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding([.leading, .trailing])
        EmptyView()
            .task {
                await viewModel.search(teachers: "")
            }
    }
}

#Preview {
    SelectTeacherView(viewModel: .init(action: { }))
}
