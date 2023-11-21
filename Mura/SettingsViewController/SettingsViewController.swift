//
//  SettingsViewController.swift
//  Mura
//
//  Created by Maxim Tvilinev on 18.10.2023.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    // MARK: - Private properties

    let upgrateLabel = UILabel()
    let detailsUpgrateLabel = UILabel()
    let imageView = UIImageView()

    let weekPriceButton = UIButton()
    let monthPriceButton = UIButton()
    let yearPriceButton = UIButton()

    var arrayOfProducts = [SKProduct]()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()


        subscriptionsInfo.validate(productIdentifiers: ["maqal.app"]) { products in
            if let product = products.first, let period = product.subscriptionPeriod {
                let title = product.localizedPrice + " / " + Self.format(unit: period.unit, numberOfUnits: period.numberOfUnits)
                DispatchQueue.main.async {
                    self.yearPriceButton.setTitle(title, for: .normal)
                }

                self.arrayOfProducts = products
            }
        }
    }

    // MARK: -

    static var componentFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        var calendar = Calendar.current
                calendar.locale = Locale(identifier: "ru_RU")
        formatter.calendar = calendar

        return formatter
    }

    static func format(unit: SKProduct.PeriodUnit, numberOfUnits: Int) -> String! {
        var dateComponents = DateComponents()
        var calendar = Calendar.current
                calendar.locale = Locale(identifier: "ru_RU")
        dateComponents.calendar = calendar
        componentFormatter.allowedUnits = [.year]
        switch unit {
        case .day:
            dateComponents.setValue(numberOfUnits, for: .day)
        case .week:
            dateComponents.setValue(numberOfUnits, for: .weekOfMonth)
        case .month:
            dateComponents.setValue(numberOfUnits, for: .month)
        case .year:
            dateComponents.setValue(numberOfUnits, for: .year)
        default:
            return nil
        }

        return componentFormatter.string(from: dateComponents)
    }
    // MARK: - Subscriptions

    let subscriptionsInfo = SubscriptionService()


    // MARK: - Private methods

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(upgrateLabel)
        upgrateLabel.text = "Обновить до Pro"
        upgrateLabel.textColor = Colors.DarkGrayColor
        upgrateLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        upgrateLabel.textAlignment = .center

        view.addSubview(imageView)
        imageView.image = UIImage(named: "LogoBG")

        view.addSubview(detailsUpgrateLabel)
        detailsUpgrateLabel.text = "Полный доступ ко всем функциям приложения / Убрать рекламу"
        detailsUpgrateLabel.textColor = Colors.DarkGrayColor
        detailsUpgrateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        detailsUpgrateLabel.textAlignment = .center
        detailsUpgrateLabel.numberOfLines = 0

        view.addSubview(weekPriceButton)
        weekPriceButton.setTitle("₸ 1 490 / Неделя", for: .normal)

        view.addSubview(monthPriceButton)
        monthPriceButton.setTitle("₸ 1 490 / Месяц", for: .normal)

        view.addSubview(yearPriceButton)
        yearPriceButton.setTitle("₸ 1 490 / Год", for: .normal)
        yearPriceButton.addTarget(self, action: #selector(addProductForYear), for: .touchUpInside)

        for settings in [weekPriceButton, monthPriceButton, yearPriceButton] {
            settings.backgroundColor = Colors.BlueColor
            settings.layer.cornerRadius = 16
        }
    }

    private func setupConstraints() {
        upgrateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(upgrateLabel.snp.bottom).offset(24)
            make.size.equalTo(125)
            make.centerX.equalToSuperview()
        }

        detailsUpgrateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        weekPriceButton.snp.makeConstraints { make in
            make.top.equalTo(detailsUpgrateLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 32)
            make.height.equalTo(48)
        }

        monthPriceButton.snp.makeConstraints { make in
            make.top.equalTo(weekPriceButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 32)
            make.height.equalTo(48)
        }

        yearPriceButton.snp.makeConstraints { make in
            make.top.equalTo(monthPriceButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 32)
            make.height.equalTo(48)
        }
    }

    @objc func addProductForYear() {

        if let product = arrayOfProducts.first {
            subscriptionsInfo.purchase(product: product) { purchased in
                if purchased {
                    print("Ok")
                } else {
                    print("Not ok!:(")
                }
            }
        }
    }
}
