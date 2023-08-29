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
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск пословиц"

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
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

        tableView.register(
            RandomMaqalCell.self,
            forCellReuseIdentifier: RandomMaqalCell.ID)

        tableView.register(
            SupportCell.self,
            forCellReuseIdentifier: SupportCell.ID)
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

            cell.goToMaqalVC = { [weak self] indexPath in
                let maqal = maqalDatabase[indexPath.row]
                let maqalVC = MaqalViewController(maqal: maqal, title: maqal.title)
                self?.navigationController?.pushViewController(maqalVC, animated: true)
            }

            return cell

        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RandomMaqalCell.ID,
                for: indexPath
            ) as? RandomMaqalCell else { return UITableViewCell() }

            cell.selectionStyle = .none

            cell.refreshButtonAction()

            return cell

        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SupportCell.ID,
                for: indexPath
            ) as? SupportCell else { return UITableViewCell() }

            cell.selectionStyle = .none

            cell.goToNextVC = { [weak self] in
                let supportVC = SupportView()
                self?.present(supportVC, animated: true)
            }

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
            return nil
        default:
            break
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return 270

        } else if indexPath.section == 1 {

//            let maqalDataBase = maqalDatabase.first?.maqals[indexPath.row]
//
//            let constraintTitleSize = CGSize(width: view.frame.width - 64, height: CGFloat.greatestFiniteMagnitude)
//
//            let titleLabel = UILabel()
//            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//            titleLabel.numberOfLines = 0
//            titleLabel.text = maqalDataBase?.title
//            let titleLabelSize = titleLabel.sizeThatFits(constraintTitleSize)
//
//            let descriptionLabel = UILabel()
//            descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//            descriptionLabel.numberOfLines = 0
//            descriptionLabel.text = maqalDataBase?.translate
//            let descriptionLabelSize = titleLabel.sizeThatFits(constraintTitleSize)
//
//            return 20 + 12 + 12 + titleLabelSize.height + descriptionLabelSize.width + 8

            return 250

        } else if indexPath.section == 2 {
            return 60
        }

        return 0
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
