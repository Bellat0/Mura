//
//  TableHeaderCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 14.10.2023.
//

import UIKit

class TableHeaderCell: UICollectionViewCell {
    
    static let ID = "TableHeaderCell"

    // MARK: - Private properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    // MARK: - Lyfe cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25

        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.centerY.equalToSuperview()
        }
    }
}

