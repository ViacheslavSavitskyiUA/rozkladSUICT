//
//  SelectAuditoryView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 20.10.2023.
//

import SwiftUI

struct SelectAuditoryView: View {
    
    @ObservedObject var viewModel: SelectAuditoryViewModel
    
    @FocusState private var isFocusState: Bool
    
    var body: some View {
        GroupBox {
            DisclosureGroup(isExpanded: $viewModel.isOpen,
                            content: {
                VStack(spacing: 16) {
                    ForEach(viewModel.viewEntities) { item in
                        VStack {
                            Divider()
                            Text(viewModel.setupItemTitle(item))
                                .font(.gilroy(.regular, size: 14))
                                .padding(.top)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectedItem = item
                                        viewModel.textFieldText = item.number
                                        viewModel.isOpen = false
                                        isFocusState = false
                                    }
                                }
                        }
                    }
                }
            }, label: {
                TextField("Введіть № аудиторії", text: $viewModel.textFieldText)
                    .foregroundStyle(Color.black)
                    .font(.gilroy(.bold, size: 16))
                    .padding(.bottom, viewModel.isOpen ? 12 : 0)
                    .focused($isFocusState)
                    .modifier(TextFieldClearButton(text: $viewModel.textFieldText))
            })
        }
        .background(Color.pastelBianca)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding([.leading, .trailing])
    }
}

#Preview {
    SelectAuditoryView(viewModel: .init(title: "Title", inputItems: [.init(id: "", number: "325"), .init(id: "", number: "301"), .init(id: "", number: "323"), .init(id: "", number: "324")], completion: {_ in }, scrollToTop: { _ in}))
}
