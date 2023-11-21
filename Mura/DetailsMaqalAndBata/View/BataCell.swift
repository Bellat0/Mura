//
//  BataCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 12.10.2023.
//

import UIKit

class BataCell: UITableViewCell {

    static let ID = "BataCell"

    //MARK: - Private properties

    private let titleLabel = UILabel()

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
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
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

    //MARK: - Configure methods

    func configureCell(bata: BataModel) {
        self.titleLabel.text = bata.title
    }
}
