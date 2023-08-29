//
//  RandomMaqalCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class RandomMaqalCell: UITableViewCell {

    static let ID = "RandomMaqalCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let colorRingView = UIImageView()
    private let refreshButton = UIButton(type: .custom)
    private let lineImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let stackView = UIStackView()

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = Colors.LightGrayColor

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

        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Colors.LightGrayColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        descriptionLabel.numberOfLines = 0

        contentView.addSubview(colorRingView)
        colorRingView.image = UIImage(named: "ColorRing")

        contentView.addSubview(lineImageView)
        lineImageView.image = UIImage(named: "Line")

        contentView.addSubview(refreshButton)
        refreshButton.setImage(UIImage(named: "ClearLogo"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchUpInside)

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.axis = .vertical
        stackView.alignment = .firstBaseline
        stackView.spacing = 8
        stackView.distribution = .fillEqually
    }

    private func setupConstraints() {

        rectView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }

        colorRingView.snp.makeConstraints { make in
            make.leading.equalTo(rectView).offset(16)
            make.centerY.equalTo(rectView)
            make.size.equalTo(80)
        }

        refreshButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(colorRingView)
            make.size.equalTo(80)
        }

        lineImageView.snp.makeConstraints { make in
            make.leading.equalTo(colorRingView.snp.trailing).offset(16)
            make.top.equalTo(rectView).offset(4)
            make.bottom.equalTo(rectView).offset(-4)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(lineImageView).offset(16)
            make.top.equalTo(rectView.snp.top).offset(12)
            make.trailing.equalTo(rectView.snp.trailing).offset(-16)
            make.bottom.equalTo(rectView.snp.bottom).offset(-12)
        }
    }

    //MARK: - Actions

    @objc func refreshButtonAction() {
        UIView.animate(withDuration: 0.1, animations: {
            self.refreshButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in

            UIView.animate(withDuration: 0.1) {
                self.refreshButton.transform = CGAffineTransform.identity
            }
        }

        let randomThemeIndex = Int.random(in: 0..<maqalDatabase.count)
        let randomMaqalIndex = Int.random(in: 0..<maqalDatabase[0].maqals.count)
        
        configureCell(data: maqalDatabase[randomThemeIndex].maqals[randomMaqalIndex])
    }

    //MARK: - Configure methods

    func configureCell(data: Maqal) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.translate
    }
}
