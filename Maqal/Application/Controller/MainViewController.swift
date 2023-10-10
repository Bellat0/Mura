//
//  ViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit
import SnapKit
import GoogleMobileAds

class MainViewController: UIViewController, GADFullScreenContentDelegate {

    //MARK: - Private properties

    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let titleImageView = UIImageView()

    //MARK: - AdMob

    private var interstitial: GADInterstitialAd?
    private var bannerView: GADBannerView!

    //MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationItem.titleView = titleImageView

        setupViews()
        setupConstraints()
        detailsTableView()

        setupAdMob()
        addBannerViewToView()
    }

    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(titleImageView)
        titleImageView.image = UIImage(named: "LogoTitle")
        titleImageView.contentMode = .scaleAspectFill

        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"

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
            make.size.equalTo(24)
        }
    }

    private func detailsTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            TableViewHeaderSection.self,
            forHeaderFooterViewReuseIdentifier: TableViewHeaderSection.ID)

        tableView.register(
            MaqalCollectionCell.self,
            forCellReuseIdentifier: MaqalCollectionCell.ID)

        tableView.register(
            BataCollectionView.self,
            forCellReuseIdentifier: BataCollectionView.ID)
    }

    func doSomething(_ sender: Any) {
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }

    //MARK: - Setup AdMob

    private func setupAdMob() {
        let request = GADRequest()

        GADInterstitialAd.load(
            withAdUnitID: themeTappedKey,
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

    private func addBannerViewToView() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = bannerKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        view.addSubview(bannerView)
        bannerView.backgroundColor = .clear

        bannerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(320)
        }
    }
}

//MARK: - Table view data source

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
                withIdentifier: MaqalCollectionCell.ID,
                for: indexPath
            ) as? MaqalCollectionCell else { return UITableViewCell() }

            cell.goToMaqalVC = { [weak self] indexPath in
                DispatchQueue.main.async {
                    if let interstitial = self?.interstitial {
                        interstitial.present(fromRootViewController: self!)
                    } else {
                        print("Ad wasn't ready")
                    }
                }

                let maqal = maqalDatabase[indexPath.row]
                let maqalVC = MaqalViewController(maqal: maqal, title: maqal.title)
                self?.navigationController?.pushViewController(maqalVC, animated: true)
            }

            cell.selectionStyle = .none

            return cell

        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BataCollectionView.ID,
                for: indexPath
            ) as? BataCollectionView else { return UITableViewCell() }

            cell.selectionStyle = .none

            return cell

        }

        return UITableViewCell()
    }

    //MARK: - Header section

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TableViewHeaderSection.ID
        ) as? TableViewHeaderSection else { return nil }

        switch section {
        case 0:
            headerView.configureTitle(title: "Пословицы")
        case 1:
            headerView.configureTitle(title: "Бата")
        case 2:
            return nil
        default:
            break
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            return 450
        case 1:
            return 270
        default:
            return 100
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 30
        case 1:
            return 30

        default:
            return 10
        }
    }

    //MARK: - Table view didSelectRowAt

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Search controller delegate

extension MainViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
