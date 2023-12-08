//
//  RandomMaqalCell.swift
//  Mura
//
//  Created by Maxim Tvilinev on 08.12.2023.
//

import UIKit

class RandomMaqalCell: UITableViewCell {

    static let ID = "RandomMaqalCell"

    // MARK: - Properties

    private let ornamentImageView = UIImageView()
    private let rectangleView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let stackView = UIStackView()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    private func setupViews() {

        contentView.addSubview(rectangleView)
        rectangleView.backgroundColor = Colors.BlueColor
        rectangleView.layer.cornerRadius = 25

        contentView.addSubview(ornamentImageView)
        ornamentImageView.image = UIImage(named: "LogoNoBg")

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
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    }

    private func setupConstraints() {
        rectangleView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.leading.equalTo(contentView).offset(8)
            make.trailing.equalTo(contentView).offset(-8)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(rectangleView).offset(8)
            make.bottom.equalTo(rectangleView).offset(-8)
            make.leading.equalTo(rectangleView).offset(8)
            make.trailing.equalTo(rectangleView).offset(-8)
        }

        ornamentImageView.snp.makeConstraints { make in
            make.trailing.equalTo(rectangleView)
            make.bottom.equalTo(rectangleView)
            make.width.equalTo(60)
            make.height.equalTo(80)
        }
    }

    // MARK: - Configure

    func configure(maqalData: Maqal) {
        self.titleLabel.text = maqalData.title.uppercased()
        self.descriptionLabel.text = maqalData.translate.uppercased()
    }
}
