//
//  OnboardingCell.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 10/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import SnapKit

class OnboardingCell: UICollectionViewCell {
    
    static let onboardingCellId = "OnboardingCell"
    
    var onboardingPageViewModel: OnboardingPageViewModel? {
        didSet {
            pageImageView.image = onboardingPageViewModel?.image
            pageTitle.text = onboardingPageViewModel?.title
            pageText.text = onboardingPageViewModel?.text
        }
    }
    
    private lazy var onboardingCellStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pageImageView,pageTitle,pageTextStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    let pageImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .cyan
        iv.clipsToBounds = true
        return iv
    }()
    
    let pageTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 25.0, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var pageTextStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pageText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return stack
    }()
    
    let pageText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        text.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(onboardingCellStack)
        
        onboardingCellStack.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        pageImageView.snp.makeConstraints { make in
            make.height.equalTo(contentView.frame.width)
        }
        
        pageTitle.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
}
