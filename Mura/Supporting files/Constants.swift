//
//  Constants.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

enum Colors {
    static let BlueColor = UIColor.rgb(r: 39, g: 77, b: 203)
    static let GrayRectColor = UIColor.rgb(r: 242, g: 243, b: 245)
    static let GrayColor = UIColor.rgb(r: 90, g: 90, b: 90)
    static let LightGrayColor = UIColor.rgb(r: 245, g: 245, b: 245)
    static let DarkGrayColor = UIColor.rgb(r: 59, g: 59, b: 59)
    static let PurpleColor = UIColor.rgb(r: 92, g: 68, b: 232)
    static let GreenColor = UIColor.rgb(r: 117, g: 169, b: 155)
    static let GreenLightColor = UIColor.rgb(r: 25, g: 195, b: 125)
    static let OrangeColor = UIColor.rgb(r: 249, g: 114, b: 73)
}

//MARK: - Enum for collection view insets

enum LayoutCollectionView {
    static let maqalItems: CGFloat = 3
    static let bataItems: CGFloat = 2
    static let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
}
