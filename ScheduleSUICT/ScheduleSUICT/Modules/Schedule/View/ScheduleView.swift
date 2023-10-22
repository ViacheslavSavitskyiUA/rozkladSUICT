//
//  ScheduleView.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI
import Combine

struct ScheduleView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    @State private var isPulsing = false
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Color.white
                    
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("backArrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .padding(.leading, 16)
                        }
                        Spacer()
                    }
                    
                    Text(viewModel.navigationTitle)
                        .font(.system(size: 16))
                        .bold()
                    
                    HStack {
                        Spacer()
                        showFavorite(type: viewModel.type)
                    }
                }
                .frame(height: 48)
            }
            showView(isError: viewModel.isShowErrorView)
        }
        .navigationBarHidden(true)
        
        .popUpNavigationView(show: $viewModel.isShowLoader, content: {
            LoaderView()
        })
        .popUpNavigationView(show: $viewModel.isShowSaveAlert, content: {
            SavePopUpView(savePopUpType: viewModel.userDataStatus == .unsaved ? .save : .remove) {
                viewModel.userDataStatus == .unsaved ? viewModel.saveUserData() : viewModel.unsaveUserData()
                viewModel.isShowSaveAlert = false
            } cancel: {
                viewModel.isShowSaveAlert = false
            }
        })
        .task {
            viewModel.setupView()
        }
    }
    
    @ViewBuilder func showLessons(_ hasLessons: Bool) -> some View {
        switch hasLessons {
        case true: RozkladListView(viewModel: viewModel.rozkladListViewModel)
        case false: EmptyLessonsView()
        }
    }
    
    @ViewBuilder func showView(isError: Bool) -> some View {
        switch isError {
        case true:
            NetworkErrorView()
        case false:
            VStack {
                DayCollectionView(viewModel: viewModel.dayCollectionViewModel)
                    .background(Color.white)
                
                showLessons(!viewModel.selectDay.isEmpty)
            }
        }
    }
    
    @ViewBuilder func showFavorite(type: UserType) -> some View {
        switch type {
        case .student, .teacher:
            Button {
                withAnimation {
                    viewModel.isShowSaveAlert = true
                }
                
            } label: {
                Image(systemName: viewModel.checkReturnSaveImage())
            }
            .frame(width: 24, height: 24)
            .padding(.trailing, 16)
            .opacity(viewModel.isShowErrorView ? 0 : 1)
        default: EmptyView()
        }
    }
}

#Preview {
    ScheduleView(viewModel: .init(searchId: 569, type: .unowned, title: "zamriy"))
}
