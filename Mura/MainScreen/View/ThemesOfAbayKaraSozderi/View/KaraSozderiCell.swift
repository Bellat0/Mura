//
//  AbayKaraSozderiCell.swift
//  Mura
//
//  Created by Maxim Tvilinev on 27.11.2023.
//

import UIKit

class KaraSozderiCell: UITableViewCell {

    static let ID = "KaraSozderiCell"

    // MARK: - Properties

    private let rectView = UIView()
    private let titleLabel = UILabel()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    var themeSelectionHandler: ((IndexPath) -> Void)?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.addSubview(rectView)
        rectView.backgroundColor = Colors.GrayRectColor
        rectView.layer.cornerRadius = 25

        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.text = aboutKaraSozderi
        titleLabel.textAlignment = .center
        titleLabel.textColor = Colors.GrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)

        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .clear
    }

    private func setupConstraints() {
        rectView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.leading.equalTo(contentView).offset(8)
            make.trailing.equalTo(contentView).offset(-8)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(rectView).offset(16)
            make.leading.equalTo(rectView).offset(8)
            make.trailing.equalTo(rectView).offset(-8)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(rectView)
            make.leading.equalTo(rectView).offset(8)
            make.trailing.equalTo(rectView)
        }
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            ThemesOfKaraSozderiCell.self,
            forCellWithReuseIdentifier: ThemesOfKaraSozderiCell.ID)
    }
}

// MARK: - Collection view data source

extension KaraSozderiCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return karaSozderiDataBase.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ThemesOfKaraSozderiCell.ID,
            for: indexPath
        ) as? ThemesOfKaraSozderiCell else { return UICollectionViewCell() }

        let data = karaSozderiDataBase[indexPath.row]
        cell.configure(data: data)
        

        return cell
    }

    // MARK: - Collection view didSelectItemAt

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        themeSelectionHandler?(indexPath)
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension KaraSozderiCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = 8 * (LayoutCollectionView.maqalItems + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth / LayoutCollectionView.maqalItems

        return CGSize(width: itemWidth + 8, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return LayoutCollectionView.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 1
    }
}
