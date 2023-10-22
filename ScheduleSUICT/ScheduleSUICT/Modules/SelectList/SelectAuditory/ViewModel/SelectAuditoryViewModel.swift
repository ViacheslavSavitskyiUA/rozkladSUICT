//
//  SelectAuditoryViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 20.10.2023.
//

import SwiftUI
import SwiftSoup

class SelectAuditoryViewModel: ObservableObject {
    
    @Published var isOpen: Bool = false
    
    @Published var basicEntities: [AuditoryEntity]
    
    @Published var viewEntities: [AuditoryEntity] = []
    
    @Published var selectedItem: AuditoryEntity? = nil {
        didSet {
            completion?(selectedItem != nil ? true : false)
            if selectedItem != nil {
                isOpen = false
            }
            
            print(selectedItem?.number)
        }
    }
    
    @Published var textFieldText: String = "" {
        didSet {
            scrollToTop?(.init(id: "", number: "")) // TODO: - Mock
            
            if textFieldText.count == 0 {
                viewEntities = basicEntities
            } else {
                viewEntities = basicEntities.filter({ $0.number.contains(textFieldText) })
            }
            
            if selectedItem?.number != "" 
                && selectedItem?.number != nil
                && selectedItem?.number == textFieldText {
                completion?(true)
            } else {
                selectedItem = nil
                withAnimation(.easeInOut) {
                    isOpen = true
                }
                completion?(false)
            }
        }
    }
    
    private var scrollToTop: ((AuditoryEntity) -> Void)?
    private var completion: ((Bool) -> Void)?
    private var defaultTitle: String
    
    init(title: String,
         inputItems: [AuditoryEntity],
         completion: ((Bool) -> Void)?,
         scrollToTop: ((AuditoryEntity) -> Void)?) {
        self.defaultTitle = title
        self.basicEntities = inputItems
        self.viewEntities = inputItems
        
        self.completion = completion
        self.scrollToTop = scrollToTop
    }
    
    deinit {
        selectedItem = nil
    }
    
    // MARK: - Methods
    func setupItemTitle(_ item: AuditoryEntity) -> String {
        return "      \(item.number)      "
    }
    
    func setupSelectTitle() -> String {
        if selectedItem == nil {
            return defaultTitle
        }
        return selectedItem?.number ?? ""
    }
}
