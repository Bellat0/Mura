//
//  ViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit
import SnapKit
import GoogleMobileAds

class MainViewController: UIViewController {

    // MARK: - Properties

    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let titleImageView = UIImageView()

    private let tableHeader = TableHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))

    private var interstitial: GADInterstitialAd?

    // MARK: - Dependencies

    private var subscriptionService = SubscriptionService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = titleImageView

        setupViews()
        setupConstraints()
        setupTableView()

        setupAdMob()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white

        view.addSubview(titleImageView)
        titleImageView.image = UIImage(named: "LogoBG")
        titleImageView.contentMode = .scaleAspectFill

        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск пословиц"

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }

    private func setupConstraints() {

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        titleImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
    }

    private func setupTableView() {
        tableHeader.bannerView.rootViewController = self
        tableView.tableHeaderView = tableHeader

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            TableViewHeaderSection.self,
            forHeaderFooterViewReuseIdentifier: TableViewHeaderSection.ID)

        tableView.register(
            MaqalsCell.self,
            forCellReuseIdentifier: MaqalsCell.ID)

        tableView.register(
            BatasCell.self,
            forCellReuseIdentifier: BatasCell.ID)
    }

    // MARK: - Setup AdMob

    private func setupAdMob() {
        let request = GADRequest()

        DispatchQueue.main.async {
            GADInterstitialAd.load(
                withAdUnitID: interstitialBannerAd,
                request: request,
                completionHandler: { [self] ad, error in

                    if let error = error {
                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                        return
                    }

                    interstitial = ad
                    interstitial?.fullScreenContentDelegate = self
                }
            )
        }
    }

    func addInterstitialAd() {
        if let interstitial = self.interstitial {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MaqalsCell.ID,
                for: indexPath
            ) as? MaqalsCell else { return UITableViewCell() }

            cell.themeSelectionHandler = { [weak self] indexPath in

                // #warning восстановить покупки после удаления прилы
                // проверять активна ли подписка

                if self?.subscriptionService.isPurchased == true {
                    self?.addInterstitialAd()
                }

                let maqal = maqalDatabase[indexPath.row]
                let maqalVC = MaqalViewController(maqal: maqal, title: maqal.themeTitle)
                self?.navigationController?.pushViewController(maqalVC, animated: true)
            }

            cell.selectionStyle = .none

            return cell

        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BatasCell.ID,
                for: indexPath
            ) as? BatasCell else { return UITableViewCell() }

            cell.selectionStyle = .none

            cell.bataSelectionHandler = { [weak self] indexPath in

                self?.addInterstitialAd()

                let bata = bataDataBase[indexPath.row]
                let bataVC = BataViewController(bata: bata, title: bata.title)
                self?.navigationController?.pushViewController(bataVC, animated: true)
            }

            cell.selectionStyle = .none

            return cell

        }

        return UITableViewCell()
    }

    // MARK: - Header section

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TableViewHeaderSection.ID
        ) as? TableViewHeaderSection else { return nil }

        switch section {
        case 0:
            headerView.configureTitle(title: "Пословицы")
        case 1:
            headerView.configureTitle(title: "Бата")
        default:
            break
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        default:
            return 30
        }
    }

    // MARK: - heightForRowAt

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            // TODO: в будущем сделать динамические размеры, вкл коллекцию
            return 455
        case 1:
            return 260
        default:
            return 100
        }
    }

    // MARK: - Table view didSelectRowAt

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search controller delegate

extension MainViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

// MARK: - AdMob repeat

extension MainViewController: GADFullScreenContentDelegate {

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        setupAdMob()
    }
}
