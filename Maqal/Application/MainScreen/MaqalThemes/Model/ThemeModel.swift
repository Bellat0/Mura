//
//  ThemeModel.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import Foundation

struct Theme {
    let title: String
    let image: String
    let themeTitle: String
    let themeTranslate: String
    let maqals: [Maqal]
}

struct Maqal {
    let title: String
    let translate: String
    var isFavourite: Bool
}
