//
//  BataCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 12.10.2023.
//

import UIKit

class BataCell: UITableViewCell {

    static let ID = "BataCell"

    // MARK: - Propertiese

    private let titleLabel = UILabel()

    //MARK: - Lifecycle

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
        contentView.addSubview(titleLabel)
        titleLabel.textColor = Colors.DarkGrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    // MARK: - Configure

    func configureCell(bata: BataModel) {
        self.titleLabel.text = bata.title
    }
}
