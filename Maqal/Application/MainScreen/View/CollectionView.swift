//
//  CollectionCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class CollectionCell: UITableViewCell {

    static let ID = "CollectionCell"

    //MARK: - Enum for collection view insets

    enum Layout {
        static let items: CGFloat = 2
        static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    //MARK: - Private properties

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
        detailsCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(270)
        }
    }

    private func detailsCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            ThemesCollectionCell.self,
            forCellWithReuseIdentifier: ThemesCollectionCell.ID)
    }
}

//MARK: - Collection view data source

extension CollectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maqalDatabase.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ThemesCollectionCell.ID,
            for: indexPath
        ) as? ThemesCollectionCell else { return UICollectionViewCell() }

        let maqal = maqalDatabase[indexPath.row]
        cell.configureCell(data: maqal)

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = 20 * (Layout.items + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth / Layout.items

        return CGSize(width: itemWidth, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Layout.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return Layout.insets.right - 4
    }
}
