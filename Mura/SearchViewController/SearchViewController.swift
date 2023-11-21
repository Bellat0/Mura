//
//  SearchViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 29.08.2023.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties

    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()

    private var filteredMaqal = [Maqal]()

    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.async { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
        }
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(tableView)

        searchController.isActive = true
        searchController.searchBar.placeholder = "Поиск пословиц"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            MaqalCell.self,
            forCellReuseIdentifier: MaqalCell.ID)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }
}

// MARK: - Table view data source

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMaqal.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MaqalCell.ID,
            for: indexPath
        ) as? MaqalCell else { return UITableViewCell() }

        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }

        cell.configureCell(data: filteredMaqal[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search delegate

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        filterContentForSearchText(text)
    }

    private func filterContentForSearchText(_ searchText: String) {
        let allMaqals = Array(maqalDatabase.map { $0.maqals }).joined()

        filteredMaqal = allMaqals.filter({ maqal in
            return maqal.translate.lowercased().contains(searchText.lowercased()) || maqal.title.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }
}
