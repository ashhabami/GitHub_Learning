//
//  ViewController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 06/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import CleanCore
import CleanPlatform

class OnboardingViewController: BaseViewController {
    
    private let layout = OnboardingLayout()
    private let presenter: OnboardingPresenter
    private var onboardingPagesVM = [OnboardingPageViewModel]()

    override func loadView() {
        view = layout
    }
    
    init(
        onboardingPresenter: OnboardingPresenter
    ) {
        self.presenter = onboardingPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.pagesCollectionView.dataSource = self
        layout.pagesCollectionView.delegate = self
        presenter.viewDidLoad()
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingPagesVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.onboardingCellId, for: indexPath) as! OnboardingCell
        let item = onboardingPagesVM[indexPath.item]
        cell.pageImageView.image = item.image
        cell.pageTitle.text = item.title
        cell.pageText.text = item.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: layout.pagesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension OnboardingViewController: OnboardingView {
    
    func setNumberOfPagesControls(_ controls: Int) {
        layout.pagesControl.numberOfPages = controls
    }
    
    func setPages(_ pages: [OnboardingPageViewModel]) {
        self.onboardingPagesVM = pages
    }
    
}
