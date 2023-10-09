//
//  BataCollectionCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 02.10.2023.
//

import UIKit

class BataCollectionCell: UICollectionViewCell {
    
    static let ID = "BataCollectionCell"

    //MARK: - Private properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    //MARK: - Lyfe cycle

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

        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Colors.LightGrayColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }

    //MARK: - Configure methods

    func configureCell(data: Theme) {
        self.titleLabel.text = data.themeTitle.uppercased()
        self.descriptionLabel.text = data.themeTranslate.uppercased()
        self.imageView.image = UIImage(named: data.image)
    }

}
