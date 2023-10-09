//
//  CollectionCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 28.08.2023.
//

import UIKit

class MaqalCollectionCell: UITableViewCell {

    static let ID = "CollectionCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let titleLabel = UILabel()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    var goToMaqalVC: ((IndexPath) -> Void)?

    //MARK: - View lifecycle

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
        contentView.addSubview(rectView)
        rectView.backgroundColor = Colors.GrayRectColor
        rectView.layer.cornerRadius = 25

        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Пословица - это короткое, звучное высказывание, содержащее мудрость, жизненный опыт или народную мораль"
        titleLabel.textAlignment = .center
        titleLabel.textColor = Colors.GrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)

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

    private func detailsCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            ThemesCollectionCell.self,
            forCellWithReuseIdentifier: ThemesCollectionCell.ID)
    }
}

//MARK: - Collection view data source

extension MaqalCollectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maqalDatabase.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ThemesCollectionCell.ID,
            for: indexPath
        ) as? ThemesCollectionCell else { return UICollectionViewCell() }

        let theme = maqalDatabase[indexPath.row]
        cell.configureCell(data: theme)

        return cell
    }

    //MARK: - Collection view didSelectItemAt

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToMaqalVC?(indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MaqalCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = 8 * (Layout.maqalItems + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth / Layout.maqalItems

        return CGSize(width: itemWidth + 8, height: 170)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Layout.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 1
    }
}
