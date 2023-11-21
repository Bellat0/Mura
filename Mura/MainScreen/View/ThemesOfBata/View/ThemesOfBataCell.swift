//
//  BataCollectionCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 02.10.2023.
//

import UIKit

class ThemesOfBataCell: UICollectionViewCell {
    
    static let ID = "BataCollectionCell"

    //MARK: - Private properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = Colors.PurpleColor

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.layer.cornerRadius = 25

        contentView.addSubview(imageView)

        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-4)
        }
    }

    //MARK: - Configure methods

    func configure(bata: BataThemesModel) {
        self.titleLabel.text = bata.title.uppercased()
        self.imageView.image = UIImage(named: bata.image)
    }
}
