//
//  KaraSozderiViewController.swift
//  Mura
//
//  Created by Maxim Tvilinev on 27.11.2023.
//

import UIKit

class KaraSozderiViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView()
    private var titleHeader: String

    // MARK: -  Dependencies

    private var karaSoz: KaraSozModel

    // MARK: - Init

    init(karaSozderi: KaraSozModel, title: String) {
        self.karaSoz = karaSozderi
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
            MaqalCell.self,
            forCellReuseIdentifier: MaqalCell.ID)
    }
}

// MARK: - Table view data source

extension KaraSozderiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return karaSoz.maqals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MaqalCell.ID,
            for: indexPath
        ) as? MaqalCell else { return UITableViewCell() }

        cell.selectionStyle = .none

        let karaSoz = karaSoz.maqals[indexPath.row]
        cell.configureKaraSozderi(data: karaSoz)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
