//
//  OnboardingLayout.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 09/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import SnapKit

class OnboardingLayout: UIView {
    
    private lazy var onboardingStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pagesCollectionView, pagesControl, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let pagesCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.allowsSelection = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        cv.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.onboardingCellId)
        let layout = (cv.collectionViewLayout as? UICollectionViewFlowLayout)
        layout?.scrollDirection = .horizontal
        return cv
    }()
    
    let pagesControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(onboardingStack)
        
        onboardingStack.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        pagesControl.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
}
