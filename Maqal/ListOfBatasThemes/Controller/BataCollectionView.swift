//
//  ListBataCell.swift
//  Maqal
//
//  Created by Maxim Tvilinev on 02.10.2023.
//

import UIKit

class BataCollectionView: UITableViewCell {

    static let ID = "BataCollectionCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let titleLabel = UILabel()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    // MARK: - Closures

    var bataClosure: ((IndexPath) -> Void)?

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
        titleLabel.text = aboutBata
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
            BataCollectionCell.self,
            forCellWithReuseIdentifier: BataCollectionCell.ID)
    }
}

//MARK: - Collection view data source

extension BataCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bataDataBase.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BataCollectionCell.ID,
            for: indexPath
        ) as? BataCollectionCell else { return UICollectionViewCell() }

        let bata = bataDataBase[indexPath.row]
        cell.configureCell(bata: bata)

        return cell
    }

    // MARK: - didSelect

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bataClosure?(indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension BataCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bataDatabase = bataDataBase[indexPath.row].title

        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.text = bataDatabase
        titleLabel.numberOfLines = 0

        let titleConstraints = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let titleSize = titleLabel.sizeThatFits(titleConstraints)

        let itemWidth = 15 + titleSize.width + 25

        return CGSize(width: itemWidth, height: 150)
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
