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

func karaSozderiItemSize(indexPath: IndexPath) -> CGFloat {

    let bataDatabase = karaSozderiDataBase[indexPath.row].themeTitle

    let titleLabel = UILabel()
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.text = bataDatabase
    titleLabel.numberOfLines = 0

    let titleConstraints = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    let titleSize = titleLabel.sizeThatFits(titleConstraints)

    let itemWidth = 15 + titleSize.width + 25

    return itemWidth
}

func randomMaqalCellHeight(indexPath: IndexPath, randomThemeIndex: Int, randomMaqalIndex: Int) -> CGFloat {

    let maqalData = maqalDatabase[randomThemeIndex].maqals[randomMaqalIndex]

    let labelConstraint = CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude)

    let titleLabel = UILabel()
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.text = maqalData.title
    titleLabel.numberOfLines = 0

    let descriptionLabel = UILabel()
    descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    descriptionLabel.text = maqalData.translate
    descriptionLabel.numberOfLines = 0

    let titleSize = titleLabel.sizeThatFits(labelConstraint)
    let descriptionSize = descriptionLabel.sizeThatFits(labelConstraint)

    print("titleSize: \(titleSize.height)")
    print("descriptionSize: \(descriptionSize.height)")

    let height = 20 + titleSize.height + 8 + descriptionSize.height + 20 + 10

    return height
}

