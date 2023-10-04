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
        GroupBox {
            DisclosureGroup(isExpanded: $viewModel.isOpen,
                            content: {
                VStack(spacing: 16) {
                    ForEach(viewModel.inputItems) { item in
                        VStack {
                            Divider()
                            Text(viewModel.setupItemTitle(item))
                                .font(.gilroy(.regular, size: 14))
                                .padding(.top)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectedItem = item
                                        viewModel.isOpen.toggle()
                                    }
                                }
                        }
                    }
                }
            }, label: {
                Text(viewModel.setupSelectTitle())
                    .foregroundStyle(Color.black)
                    .font(.gilroy(.bold, size: 16))
                    .padding(.bottom, viewModel.isOpen ? 12 : 0)
            })
        }
        .background(Color.pastelBianca)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding([.leading, .trailing])
        .inactive(viewModel.isInactive)
    }
}

#Preview {
    SelectItemView(viewModel: .init(type: .course,
                                    inputsItem: [ChoiceEntity(id: 0, shortName: nil, fullName: "2"),
                                                 ChoiceEntity(id: 1, shortName: "FCVFV", fullName: "sdcdscsdcsdcsdcsdc")],
                                    isInactive: false,
                                    completion: nil))
}
