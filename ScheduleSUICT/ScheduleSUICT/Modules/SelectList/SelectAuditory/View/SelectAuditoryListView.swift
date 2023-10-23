//
//  SelectAuditoryListView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 21.10.2023.
//

import SwiftUI

struct SelectAuditoryListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: SelectAuditoryListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                setupView(type: viewModel.screenType)
                
                NavigationLink(destination: ScheduleView(viewModel: .init(
                    searchId: Int(viewModel.auditoryViewModel.selectedItem?.id ?? "0") ?? 0,
                    type: .auditory,
                    title: viewModel.auditoryViewModel.selectedItem?.number ?? "")),
                               isActive: $viewModel.isShowRozklad) {
                    EmptyView()
                }
            }
            .popUpNavigationView(show: $viewModel.isShowLoader, content: {
                LoaderView()
            })
            .task {
                await viewModel.getRozklad()
            }
            
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.fennelFlower)
                    }
                    .inactive(viewModel.isShowLoader)
                }
            }
            .popUpNavigationView(show: $viewModel.isShowLoader) {
                LoaderView()
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder private func setupView(type: ScreenType) -> some View {
        switch type {
        case .success:
            ScrollViewReader { scrollProxy in
                ScrollView {
                    SelectAuditoryView(viewModel: viewModel.auditoryViewModel)
                }
            }
            
            Spacer()
            
            Button {
                viewModel.isShowRozklad.toggle()
            } label: {
                Text("Далі")
                    .font(.gilroy(.semibold, size: 20))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(Color.fallGold)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .inactive(!viewModel.isActiveNextButton)
//            .padding(.bottom)
        case .fail:
            NetworkErrorView()
        case .firstLoading:
            Color.clear
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
        }
    }
}

#Preview {
    SelectAuditoryListView(viewModel: .init(title: "jjj"))
}
