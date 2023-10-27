//
//  String+Extension.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 25.10.2023.
//

import Foundation

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
