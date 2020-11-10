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
        layout.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        presenter.viewDidLoad()
    }
    
    @objc private func nextButtonPressed(sender: UIButton) {
        let nextPage = Int(layout.pagesCollectionView.contentOffset.x/view.frame.width) + 1
        presenter.updatePageControlFor(nextPage)
        presenter.updatePageTo(nextPage)
        presenter.updateButtonTitleFor(nextPage)
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingPagesVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.onboardingCellId, for: indexPath) as! OnboardingCell
        let item = onboardingPagesVM[indexPath.item]
        cell.onboardingPageViewModel = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: layout.pagesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/view.frame.width)
        presenter.updatePageControlFor(page)
        presenter.updateButtonTitleFor(page)
    }
    
}

extension OnboardingViewController: OnboardingView {
    
    func setButtonTitle(_ title: String) {
        layout.nextButton.setTitle(title, for: .normal)
    }
    
    func setPageTo(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        layout.pagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setSelectedPageControlFor(_ index: Int) {
        layout.pagesControl.currentPage = index
    }
    
    func setNumberOfPagesControls(_ controls: Int) {
        layout.pagesControl.numberOfPages = controls
    }
    
    func setPages(_ pages: [OnboardingPageViewModel]) {
        self.onboardingPagesVM = pages
    }
    
}
