//
//  BataViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 12.10.2023.
//

import UIKit

class BataViewController: UIViewController {

    //MARK: - Private properties

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var bata: BataThemesModel
    private var titleHeader: String

    //MARK: - Lyfe cycle

    init(bata: BataThemesModel, title: String) {
        self.bata = bata
        self.titleHeader = title

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.LightGrayColor

        title = titleHeader

        setupViews()
        setupConstraints()
        detailsTableView()
    }


    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func detailsTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            BataCell.self,
            forCellReuseIdentifier: BataCell.ID)
    }
}

// MARK: - Table view data source

extension BataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bata.bataTitle.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BataCell.ID,
            for: indexPath
        ) as? BataCell else { return UITableViewCell() }

        let bata = bata.bataTitle[indexPath.row]
        cell.configureCell(bata: bata)

        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
