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

//    private let rectImageView = UIImageView()
//    private let button = UIButton(type: .system)
//    private let titleLabelButton = UILabel()
//
//    private let closeButton = UIButton()


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
        titleLabel.font = UIFont(name: "", size: 16)
        titleLabel.textAlignment = .center

        view.addSubview(descriptionLabel)
        descriptionLabel.text = supportText
        descriptionLabel.numberOfLines = 0



//        view.addSubview(rectImageView)
//        rectImageView.image = UIImage(named: "buttonGradient")
//        rectImageView.layer.cornerRadius = 16
//        rectImageView.clipsToBounds = true
//
//        view.addSubview(button)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        view.addSubview(titleLabelButton)
//        titleLabelButton.textColor = .white
//        titleLabelButton.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        titleLabelButton.numberOfLines = 0
//        titleLabelButton.text = "Поддержать проект"
//        titleLabelButton.textAlignment = .center

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

//        rectImageView.snp.makeConstraints { make in
//            make.top.equalTo(stackView.snp.bottom).offset(24)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//        }
//
//        button.snp.makeConstraints { make in
//            make.edges.equalTo(rectImageView)
//        }
//
//        titleLabelButton.snp.makeConstraints { make in
//            make.top.equalTo(rectImageView).offset(16)
//            make.bottom.equalTo(rectImageView).offset(-16)
//            make.leading.equalTo(rectImageView).offset(16)
//            make.trailing.equalTo(rectImageView).offset(-16)
//        }
    }

    @objc func buttonAction() {
        UIPasteboard.general.string = "+7 701 268 03 14"
    }
}
