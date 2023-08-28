//
//  ThemesCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class ThemesCollectionCell: UICollectionViewCell {

    static let ID = "ThemesCollectionCell"

    //MARK: - Lyfe cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = Colors.BlueColor

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.layer.cornerRadius = 20
    }

    private func setupConstraints() {}

}
