//
//  CryptoPriceCell.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 06.01.2021.
//  Copyright © 2021 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CryptoPriceCell: UITableViewCell {
    
    var cryptocurrencyVM: CryptocurrencyViewModel? {
        didSet {
            guard let crypto = cryptocurrencyVM else { return }
            
            cryptocurrencyRankLabel.text = crypto.rank + "."
            cryptocurrencyLogoImageView.sd_setImage(with: crypto.imageUrl)
            cryptocurrencyPriceLabel.text = crypto.price + "/USD"
            cryptocurrencySymbolLabel.text = crypto.symbol
            cryptocurrencyPriceChangePercentageLabel.text = crypto.priceChangePercentage
            
            switch crypto.priceChange {
            case .negative: cryptocurrencyPriceChangePercentageLabel.textColor = .systemRed
            case .positive: cryptocurrencyPriceChangePercentageLabel.textColor = .systemGreen
            case .neutral:  cryptocurrencyPriceChangePercentageLabel.textColor = .black
            }
        }
    }
    
    static let identifier = "CryptoPriceCell"
    
    let cryptoPriceCellView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    let cryptocurrencyRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    let cryptocurrencyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 56/2
        return imageView
    }()
    
    let cryptocurrencyPriceChangePercentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        return label
    }()
    
    let cryptocurrencyPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    let cryptocurrencySymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var cryptocurrencyPriceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cryptocurrencyRankLabel, cryptocurrencyLogoImageView, cryptocurrencyPriceChangePercentageLabel, cryptocurrencyPriceLabel, cryptocurrencySymbolLabel])
        stack.axis = .horizontal
        stack.spacing = 7
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        backgroundColor = .clear
        addSubview(cryptoPriceCellView)
        cryptoPriceCellView.addSubview(cryptocurrencyPriceStack)
        
        cryptoPriceCellView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        }
        cryptocurrencyRankLabel.snp.makeConstraints {
            $0.width.equalTo(25)
        }
        cryptocurrencyLogoImageView.snp.makeConstraints {
            $0.width.equalTo(cryptocurrencyPriceStack.snp.height)
        }
        cryptocurrencyPriceChangePercentageLabel.snp.makeConstraints {
            $0.width.equalTo(80)
        }
        cryptocurrencyPriceStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10))
        }
    }
}
