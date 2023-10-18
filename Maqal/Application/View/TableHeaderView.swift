//
//  TableHeaderView.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 14.10.2023.
//

import UIKit

class TableHeaderView: UIView {

    // MARK: - Private properties

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    // MARK: - Внешние зависимости

    // MARK: - View lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
        detailsCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods

    private func setupViews() {
        addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 32)
            make.centerX.equalToSuperview()
        }
    }

    private func detailsCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            TableHeaderCell.self,
            forCellWithReuseIdentifier: TableHeaderCell.ID)
    }
}

// MARK: - Collection view data source

extension TableHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TableHeaderCell.ID,
            for: indexPath
        ) as? TableHeaderCell else { return UICollectionViewCell() }

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension TableHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = 8 * (Layout.maqalItems + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth / Layout.maqalItems

        return CGSize(width: itemWidth, height: 125)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Layout.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 5
    }
}
