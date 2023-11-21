//
//  Calculations.swift
//  Mura
//
//  Created by Maxim Tvilinev on 21.11.2023.
//

import UIKit

func bataItemSize(indexPath: IndexPath) -> CGFloat {

    let bataDatabase = bataDataBase[indexPath.row].title

    let titleLabel = UILabel()
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.text = bataDatabase
    titleLabel.numberOfLines = 0

    let titleConstraints = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    let titleSize = titleLabel.sizeThatFits(titleConstraints)

    let itemWidth = 15 + titleSize.width + 25

    return itemWidth
}
