//
//  ViewController.swift
//  CustomPageControl
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public var thePageControl: CustomPageControl?
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var pageControlWrapper: UIView!
    @IBOutlet weak var pageControlWrapperBottomBorder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureCollectionView()
        self.configurePageControl()
    }

    private func configurePageControl() {
        thePageControl = CustomPageControl(withFrame: pageControlWrapper.bounds, NumberOfPages: 4, CurrentPage: 0, ElementColor: .gray, SelectedElementColor: .black, ElementHeight: 7.0, ElementWidth: 7.0, SelectedElementWidth: 22.0, ElementSpacing: 4.0)
        thePageControl?.isManualPager = true
        thePageControl?.autoresizingMask = .flexibleWidth
        thePageControl?.backgroundColor = .clear
        pageControlWrapper.addSubview(thePageControl!)
        pageControlWrapperBottomBorder.backgroundColor = .lightGray
    }
    
    fileprivate func configureCollectionView() {
        let horizontalLayout = UICollectionViewFlowLayout()
        horizontalLayout.scrollDirection = .horizontal
        topCollectionView.collectionViewLayout = horizontalLayout
        topCollectionView.isPagingEnabled = true
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WalkThroughCollectionCell
        switch indexPath.row {
        case 0:
            cell.walkThroughImageView.backgroundColor = UIColor.green
        case 1:
            cell.walkThroughImageView.backgroundColor = UIColor.blue
        case 2:
            cell.walkThroughImageView.backgroundColor = UIColor.red
        case 3:
            cell.walkThroughImageView.backgroundColor = UIColor.orange
        default:
            cell.walkThroughImageView.backgroundColor = UIColor.lightGray
        }
//        cell.walkThroughImageView.image = UIImage(named: imageName)
        cell.walkThroughTitleLabel.text = "Lorem ipsum"
        cell.walkThroughSubTitleLabel.text = "Sample content."
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((topCollectionView.contentOffset.x < 0) || (topCollectionView.contentOffset.x > (CGFloat(((thePageControl?.numberOfPages)! - 1)) * topCollectionView.frame.size.width))) {
            return
        }
        let pageWidth = topCollectionView.frame.size.width
        let currentpage = topCollectionView.contentOffset.x / pageWidth
        let index1:Int = Int(floor(currentpage))
        let index2:Int = Int(ceil(currentpage))
        if index1 == index2 {
            thePageControl?.currentPage = index1
            thePageControl?.updateElementsOnCurrentPageChangeWithAnimation()
            return
        }
        let multiplier:Double = 1000
        var theDiff:Double = (Double(topCollectionView.contentOffset.x) * multiplier).truncatingRemainder(dividingBy: (Double(pageWidth) * multiplier))
        theDiff = theDiff/multiplier
        let variation2:Double = theDiff/Double(pageWidth)
        let variation1:Double = 1 - variation2
        
        thePageControl?.updateElementsOnCurrentPageChangeWithAnimation(withFirstAnimatingIndex: index1, withVariation: variation1, NextAnimatingIndex: index2, withVariation: variation2)
    }
}


