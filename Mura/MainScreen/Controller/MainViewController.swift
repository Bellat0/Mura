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

    let randomThemeIndex = Int.random(in: 0..<maqalDatabase.count)
    let randomMaqalIndex = Int.random(in: 0..<maqalDatabase.first!.maqals.count)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = titleImageView

        setupViews()
        setupConstraints()
        setupTableView()
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
            RandomMaqalCell.self,
            forCellReuseIdentifier: RandomMaqalCell.ID)

        tableView.register(
            MaqalsCell.self,
            forCellReuseIdentifier: MaqalsCell.ID)

        tableView.register(
            BatasCell.self,
            forCellReuseIdentifier: BatasCell.ID)

        tableView.register(
            KaraSozderiCell.self,
            forCellReuseIdentifier: KaraSozderiCell.ID)
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RandomMaqalCell.ID,
                for: indexPath
            ) as? RandomMaqalCell else { return UITableViewCell() }

            let maqalData = maqalDatabase[randomThemeIndex].maqals[randomMaqalIndex]
            cell.configure(maqalData: maqalData)
            
            cell.selectionStyle = .none

            return cell

        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MaqalsCell.ID,
                for: indexPath
            ) as? MaqalsCell else { return UITableViewCell() }

            cell.themeSelectionHandler = { [weak self] indexPath in

                let maqal = maqalDatabase[indexPath.row]
                let maqalVC = MaqalViewController(maqal: maqal, title: maqal.themeTitle)
                self?.navigationController?.pushViewController(maqalVC, animated: true)
            }

            cell.selectionStyle = .none

            return cell

        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BatasCell.ID,
                for: indexPath
            ) as? BatasCell else { return UITableViewCell() }

            cell.selectionStyle = .none

            cell.bataSelectionHandler = { [weak self] indexPath in

                let bata = bataDataBase[indexPath.row]
                let bataVC = BataViewController(bata: bata, title: bata.title)
                self?.navigationController?.pushViewController(bataVC, animated: true)
            }

            cell.selectionStyle = .none

            return cell

        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: KaraSozderiCell.ID,
                for: indexPath
            ) as? KaraSozderiCell else { return UITableViewCell() }

            cell.themeSelectionHandler = { [weak self] indexPath in

                let karaSozderi = karaSozderiDataBase[indexPath.row]
                let karaSozderiVC = KaraSozderiViewController(karaSozderi: karaSozderi, title: karaSozderi.themeTitle)
                self?.navigationController?.pushViewController(karaSozderiVC, animated: true)
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
            headerView.configureTitle(title: "Cлучайная пословица")
        case 1:
            headerView.configureTitle(title: "Пословицы")
        case 2:
            headerView.configureTitle(title: "Бата")
        case 3:
            headerView.configureTitle(title: "Абайдың қара сөздері")
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
            return randomMaqalCellHeight(indexPath: indexPath, randomThemeIndex: randomThemeIndex, randomMaqalIndex: randomMaqalIndex)
        case 1:
            // TODO: в будущем сделать динамические размеры, вкл коллекцию
            return 455
        case 2:
            return 260
        case 3:
            return 255
        default:
            return 250
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

