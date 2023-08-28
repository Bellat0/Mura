//
//  ViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    //MARK: - Private properties

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    //MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.LightGrayColor
        tableView.backgroundColor = Colors.LightGrayColor

        setupViews()
        setupConstrints()
        detailsTableView()
    }

    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск пословиц"

        view.addSubview(tableView)
        tableView.separatorStyle = .none
    }

    private func setupConstrints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func detailsTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            HeaderSectionView.self,
            forHeaderFooterViewReuseIdentifier: HeaderSectionView.ID)

        tableView.register(
            CollectionCell.self,
            forCellReuseIdentifier: CollectionCell.ID)
    }
}

//MARK: - Table view data source

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CollectionCell.ID,
                for: indexPath
            ) as? CollectionCell else { return UITableViewCell() }

            return cell
        }

        return UITableViewCell()
    }

    //MARK: - Header section

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderSectionView.ID
        ) as? HeaderSectionView else { return nil }

        switch section {
        case 0:
            headerView.configureTitle(title: "Темы пословиц")
        case 1:
            headerView.configureTitle(title: "Случайная пословица")
        case 2:
            headerView.configureTitle(title: "Поддержите проект")
        default:
            break
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
