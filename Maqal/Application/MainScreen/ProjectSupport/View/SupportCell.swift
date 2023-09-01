//
//  SupportCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class SupportCell: UITableViewCell {

    static let ID = "SupportCell"

    var goToNextVC: (() -> Void)?

    //MARK: - Private properties

    private let rectImageView = UIImageView()
    private let button = UIButton(type: .system)

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = Colors.LightGrayColor

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(rectImageView)
        rectImageView.image = UIImage(named: "buttonGradient")
        rectImageView.layer.cornerRadius = 16
        rectImageView.clipsToBounds = true

        contentView.addSubview(button)
        button.setTitle("О проекте", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(aboutProjectAction), for: .touchUpInside)
    }

    private func setupConstraints() {
        rectImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        button.snp.makeConstraints { make in
            make.edges.equalTo(rectImageView)
        }
    }

    //MARK: - Actions
    
    @objc func aboutProjectAction() {
        goToNextVC?()
    }
}
