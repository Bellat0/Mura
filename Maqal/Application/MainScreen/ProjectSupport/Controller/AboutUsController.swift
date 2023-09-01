//
//  AboutUsController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 01.09.2023.
//

import UIKit

class AboutUsController: UIViewController {

    //MARK: - Private properties

    private let logoView = UIImageView()
    private let versionLabel = UILabel()
    private let aboutUsLabel = UILabel()
    private let button = UIButton(type: .system)
    private let rectImageView = UIImageView()

    //MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.LightGrayColor

        setupViews()
        setupConstraints()
    }

    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(logoView)
        logoView.image = UIImage(named: "AppIcon")
        logoView.layer.cornerRadius = 16
        logoView.layer.masksToBounds = true

        view.addSubview(versionLabel)
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] else { return }
        versionLabel.text = "Версия приложения: \(version)"
        versionLabel.textColor = Colors.GrayColor
        versionLabel.font = UIFont.systemFont(ofSize: 14)

        view.addSubview(aboutUsLabel)
        aboutUsLabel.text = aboutUsText
        aboutUsLabel.numberOfLines = 0
        aboutUsLabel.font = UIFont(name: "Helvetica Neue Light", size: 16)

        view.addSubview(rectImageView)
        rectImageView.image = UIImage(named: "buttonGradient")
        rectImageView.layer.cornerRadius = 16
        rectImageView.clipsToBounds = true

        view.addSubview(button)
        button.setTitle("Поддержать проект", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    private func setupConstraints() {
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(90)
        }

        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        aboutUsLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        rectImageView.snp.makeConstraints { make in
            make.top.equalTo(aboutUsLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        button.snp.makeConstraints { make in
            make.edges.equalTo(rectImageView)
        }
    }

    //MARK: - Actions

    @objc func buttonAction() {
        let supportVC = SupportView()
        present(supportVC, animated: true)
    }
}
