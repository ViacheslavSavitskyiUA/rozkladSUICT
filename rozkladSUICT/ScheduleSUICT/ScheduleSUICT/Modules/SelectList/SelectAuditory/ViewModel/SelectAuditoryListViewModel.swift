//
//  SelectAuditoryListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 21.10.2023.
//

import Combine
import Foundation
import SwiftUI
import SwiftSoup

class SelectAuditoryListViewModel: ObservableObject {
    
    var cabinets: [AuditoryEntity] = []
    
    @Published var isActiveNextButton = false
    
    @Published var isShowLoader = false
    @Published var screenType: ScreenType = .firstLoading
    
    @Published var isShowRozklad = false
    
    @Published var auditoryViewModel: SelectAuditoryViewModel!
    
    let title: String
    
    init(title: String) {
        self.title = title
        
        setupViewModelSubview()
    }
    
    private func setupViewModelSubview() {
        auditoryViewModel = .init(title: "",
                                  inputItems: [],
                                  completion: { [weak self] isActive in
            guard let self = self else { return }
            
            self.isActiveNextButton = isActive
        }, scrollToTop: { _ in
            
        })
    }
}

// MARK: - Rozklad
extension SelectAuditoryListViewModel {
    @MainActor
    func getRozklad() async {
        isShowLoader = true
        let url = URL(string: "https://e-rozklad.dut.edu.ua/time-table/classroom") ?? URL(fileURLWithPath: "")
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let data = data {
                self.parse(html: (String(data: data, encoding: .utf8) ?? ""))
            } else {
                self.isShowLoader = false
                self.screenType = .fail
            }
        }
        task.resume()
    }

    private func parse(html: String) {
        do {
            let document = try SwiftSoup.parse(html)
            
            let option: Elements = try document.select("option")
//            print(option.array())
            cabinets = getElements(elements: option)
        } catch {
            print(error)
            isShowLoader = false
            screenType = .fail
        }
        isShowLoader = false
    }
    
    private func getElements(elements: Elements) -> [AuditoryEntity] {
        var returnArray: [AuditoryEntity] = []
        do {
            for (index, elem) in elements.array().enumerated() {
                if !(0...2).contains(index) {
                    returnArray.append(.init(id: try elem.attr("value"),
                                             number: try elem.text()))
                }
            }
        } catch {
            print(error)
            isShowLoader = false
            screenType = .fail
        }
        
//        print(returnArray)
        auditoryViewModel.basicEntities = returnArray
        auditoryViewModel.viewEntities = returnArray
        isShowLoader = false
        screenType = .success
        return returnArray
    }
}
