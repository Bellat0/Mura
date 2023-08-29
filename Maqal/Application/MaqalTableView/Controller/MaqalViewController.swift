//
//  MaqalViewController.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 29.08.2023.
//

import UIKit

class MaqalViewController: UIViewController {

    //MARK: - Private properties

    private let tableView = UITableView()

    //MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Private methods

    private func setupViews() {}
    private func setupConstraints() {}
    private func detailsTableView() {}

}

//MARK: - Table view data source

extension MaqalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

    
}
