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
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.numberOfLines = 0

        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Colors.GrayColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    //MARK: - Configure methods

    func configureCell(data: Maqal) {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.translate
    }

    func configureKaraSozderi(data: Maqal) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.translate
    }
}
