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
    private let numberLabel = UILabel()
    private let stackView = UIStackView()

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
        contentView.backgroundColor = Colors.NPurpleColor

        contentView.layer.cornerRadius = 25

        contentView.addSubview(imageView)
        imageView.image = UIImage(named: "LogoNoBg")

        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Colors.LightGrayColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.axis = .vertical
    }

    private func setupConstraints() {

        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(110)
        }

        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }

    // MARK: - Configure

    func configure(data: KaraSozModel) {
        self.titleLabel.text = data.themeTitle.uppercased()
        self.descriptionLabel.text = data.themeTranslate.uppercased()
    }
}
