//
//  MaqalCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 29.08.2023.
//

import UIKit

class MaqalCell: UITableViewCell {

    static let ID = "MaqalCell"

    //MARK: - Private properties

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.textColor = Colors.DarkGrayColor
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0

        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Colors.GrayColor
        descriptionLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        descriptionLabel.numberOfLines = 0
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    //MARK: - Configure methods

    func configureCell(data: Maqal) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.translate
    }
}
