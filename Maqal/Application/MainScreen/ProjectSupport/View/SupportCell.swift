//
//  SupportCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class SupportCell: UITableViewCell {

    static let ID = "SupportCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let titleLabel = UILabel()

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .red

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(rectView)
        rectView.layer.cornerRadius = 16
        rectView.backgroundColor = Colors.BlueColor

        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Поддержать проект"
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        rectView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(rectView).offset(16)
            make.bottom.equalTo(rectView).offset(-16)
            make.leading.equalTo(rectView).offset(16)
            make.trailing.equalTo(rectView).offset(-16)
        }
    }
}
