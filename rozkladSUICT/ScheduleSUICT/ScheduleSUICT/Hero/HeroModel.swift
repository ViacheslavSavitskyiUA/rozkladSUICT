//
//  HeroModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 03.10.2024.
//

import SwiftUI

struct HeroEntity: Identifiable {
    var id = UUID().uuidString
    
    let name: String
    let dateLife: String
    let image: String
}

let heroEntities: [HeroEntity] = [HeroEntity(name: "Ярослав Довгий", dateLife: "Загинув 06.05.2023", image: "dovhyi"),
                                  HeroEntity(name: "Микита Михайленко", dateLife: "Загинув 07.12.2022", image: "mykchailenko"),
                                  HeroEntity(name: "Владислав Неборський", dateLife: "Загинув 02.10.2022", image: "neborsky"),
                                  HeroEntity(name: "Ілля Полянський", dateLife: "Загинув 12.02.2024", image: "polyanskyi"),
                                  HeroEntity(name: "Ростислав Стадник", dateLife: "Загинув 15.02.2023", image: "stadnyik"),
                                  HeroEntity(name: "Володимир Яворський", dateLife: "Загинув 30.05.2024", image: "yavorskyi")]

//let heroCards: [Card] = [Card(cardColor: .red, title: "1"), Card(cardColor: .red, title: "2"), Card(cardColor: .red, title: "3"), Card(cardColor: .red, title: "4"), Card(cardColor: .red, title: "5"), Card(cardColor: .red, title: "6")]
