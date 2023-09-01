//
//  ViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class SupportView: UIViewController {

    //MARK: - Private properties

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let rectImageView = UIImageView()
    private let button = UIButton()

    //MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.LightGrayColor
        
        setupViews()
        setupConstraints()
    }

    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(titleLabel)
        titleLabel.text = "Поддержка проекта"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 20)

        view.addSubview(descriptionLabel)
        descriptionLabel.text = supportText
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Helvetica Neue Light", size: 16)

        view.addSubview(rectImageView)
        rectImageView.image = UIImage(named: "buttonGradient")
        rectImageView.layer.cornerRadius = 16
        rectImageView.clipsToBounds = true

        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitle("Скопировать номер", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)

    }

    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        rectImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        button.snp.makeConstraints { make in
            make.edges.equalTo(rectImageView)
        }
    }

    //MARK: - Actions

    @objc func buttonAction() {
        UIView.animate(withDuration: 0.1, animations: {
            self.rectImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.button.setTitleColor(.systemGray5, for: .normal)
        }) { (_) in

            UIView.animate(withDuration: 0.1) {
                self.rectImageView.transform = CGAffineTransform.identity
                self.button.setTitle("Номер скопирован", for: .normal)
            }
        }

        UIPasteboard.general.string = "+7 701 268 03 14"
        button.isEnabled = false
    }
}
