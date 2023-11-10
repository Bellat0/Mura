//
//  TableHeaderView.swift
//  Mura
//
//  Created by Maxim Tvilinev on 10.11.2023.
//

import UIKit
import GoogleMobileAds

class TableHeaderView: UIView {

    // MARK: - Private properties

     var bannerView: GADBannerView!

    // MARK: - View lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)

        bannerView.adUnitID = bannerAd

        DispatchQueue.main.async {
            self.bannerView.load(GADRequest())
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    func addBannerViewToView(_ bannerView: GADBannerView) {
      addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
     }
}
