//
//  MaqalViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 29.08.2023.
//

import UIKit

class MaqalViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView()
    private var titleHeader: String

    // MARK: -  Dependencies

    var maqal: Theme

    // MARK: - Init

    init(maqal: Theme, title: String) {
        self.maqal = maqal
        self.titleHeader = title
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = titleHeader

        setupViews()
        setupConstraints()
        detailsTableView()
    }
    

    //MARK: - Methods

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

extension MaqalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maqal.maqals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MaqalCell.ID,
            for: indexPath
        ) as? MaqalCell else { return UITableViewCell() }

        let maqal = maqal.maqals[indexPath.row]
        cell.configureCell(data: maqal)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Swipes

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = shareAction(at: indexPath)

        return UISwipeActionsConfiguration(actions: [shareAction])
    }

    func shareAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "") { action, view, completion in

            let maqal = self.maqal.maqals[indexPath.row]
            let shareController = UIActivityViewController(
                activityItems: [maqal.title + "\n" + maqal.translate + "\nОтправлено из приложения Maqal"], applicationActivities: nil)
            self.present(shareController, animated: true)
            completion(true)
        }

        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "square.and.arrow.up")

        return action
    }
}
