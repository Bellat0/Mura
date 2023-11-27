//
//  ThemesOfKaraSozderiCell.swift
//  Mura
//
//  Created by Maxim Tvilinev on 27.11.2023.
//

import UIKit

class ThemesOfKaraSozderiCell: UICollectionViewCell {
    
    static let ID = "ThemesOfKaraSozderiCell"

    // MARK: - Properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.backgroundColor = Colors.GreenLightColor

        contentView.layer.cornerRadius = 25

        contentView.addSubview(imageView)

        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textAlignment = .center

        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Colors.LightGrayColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textAlignment = .center
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }
    }

    // MARK: - Configure

    func configure(data: Theme) {
        self.titleLabel.text = data.themeTitle.uppercased()
        self.descriptionLabel.text = data.themeTranslate.uppercased()
        self.imageView.image = UIImage(named: data.image)
    }
}
