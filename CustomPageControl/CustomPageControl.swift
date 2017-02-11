//
//  CustomPageControl.swift
//  CustomPageControl
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

class CustomPageControl: UIView {
    
    public let kColor = "color"
    public let kFrame = "frame"
    public let animationDuration = 0.3
    
    fileprivate let localMultiplier = 3
    
    open var numberOfPages: Int = 0
    
    open var isManualPager: Bool = false
    
    fileprivate var _currentPage: Int = 0
    
    open var currentPage: Int {
        set {
            _currentPage = newValue
            if self.isManualPager == false {
                self.updateElementsOnCurrentPageChangeWithAnimation()
            }
        }
        get {
            return _currentPage
        }
    }
    
    open var elementColor: UIColor = UIColor.lightGray
    
    open var selectedElementColor: UIColor = UIColor.black
    
    open var elementHeight: CGFloat = 0.0
    
    open var elementWidth: CGFloat = 0.0
    
    open var selectedElementWidth: CGFloat = 0.0
    
    open var elementSpacing: CGFloat = 0.0
    
    fileprivate var wrapperView = UIView()
    
    convenience init(withFrame frame: CGRect, NumberOfPages numberOfPages:Int, CurrentPage currentPage:Int, ElementColor elementColor:UIColor, SelectedElementColor selectedElementColor: UIColor, ElementHeight elementHeight:CGFloat, ElementWidth elementWidth:CGFloat, SelectedElementWidth selectedElementWidth:CGFloat, ElementSpacing elementSpacing:CGFloat) {
        self.init(frame: frame)
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage
        self.elementColor = elementColor
        self.selectedElementColor = selectedElementColor
        self.elementHeight = elementHeight
        self.elementWidth = elementWidth
        self.selectedElementWidth = selectedElementWidth
        self.elementSpacing = elementSpacing
        self.drawControlLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wrapperView.center = self.center
    }
    
    open func drawControlLayout() {
        let totalWidth = self.getTotalWidthOfElements()
        wrapperView.frame = CGRect(x: 0.0, y: 0.0, width: totalWidth, height: elementHeight)
        wrapperView.center = self.center
        self.addSubview(wrapperView)
        let elementsData = self.getColorFrameArrayOfItems()
        for index in 0...(elementsData.count - 1) {
            let theElementRawData: Dictionary = elementsData[index] as! [String : Any]
            let theElementColor = theElementRawData[self.kColor] as! UIColor
            let theElementFrame = theElementRawData[self.kFrame] as! CGRect
            let theElement = UIView(frame: theElementFrame)
            theElement.backgroundColor = theElementColor
            theElement.layer.cornerRadius = CGFloat(elementHeight)/2
            theElement.tag = localMultiplier * (index + 1)
            wrapperView.addSubview(theElement)
        }
    }
    
    open func updateElementsOnCurrentPageChangeWithAnimation() {
        let elementsData = self.getColorFrameArrayOfItems()
        for index in 0...(elementsData.count - 1) {
            let theElementRawData: Dictionary = elementsData[index] as! [String : Any]
            let theElementColor = theElementRawData[self.kColor] as! UIColor
            let theElementFrame = theElementRawData[self.kFrame] as! CGRect
            let theElement = self.getPagerElement(atIndex: index)
            UIView.animate(withDuration: self.animationDuration, animations: {
                theElement?.frame = theElementFrame
                theElement?.backgroundColor = theElementColor
            })
        }
    }
    
    open func updateElementsOnCurrentPageChangeWithAnimation(withFirstAnimatingIndex index1:Int, withVariation variation1:Double, NextAnimatingIndex index2:Int, withVariation variation2:Double) {
        if index1 < 0 {
            return
        }
        let elementsData = self.getColorFrameArrayOfItems(withFirstAnimatingIndex: index1, withVariation: variation1, NextAnimatingIndex: index2, withVariation: variation2)
        for index in 0...(elementsData.count - 1) {
            let theElementRawData: Dictionary = elementsData[index] as! [String : Any]
            let theElementColor = theElementRawData[self.kColor] as! UIColor
            let theElementFrame = theElementRawData[self.kFrame] as! CGRect
            let theElement = self.getPagerElement(atIndex: index)
            UIView.animate(withDuration: self.animationDuration, animations: {
                theElement?.frame = theElementFrame
                theElement?.backgroundColor = theElementColor
            })
        }
    }
    
    open func getPagerElement(atIndex index: Int) -> UIView? {
        return wrapperView.viewWithTag(localMultiplier * (index + 1))
    }
    
    open func getTotalWidthOfElements() -> CGFloat {
        let totalWidth = ( CGFloat(numberOfPages - 1) * elementWidth ) + selectedElementWidth + ( CGFloat(numberOfPages - 1) * elementSpacing )
        return totalWidth
    }
    
    open func getColorFrameArrayOfItems() -> Array<Any> {
        var returnArray: Array<Any> = Array()
        var x: CGFloat = 0.0
        var counter = 0
        while counter < numberOfPages {
            var elementFrame = CGRect.zero
            var theColor: UIColor = selectedElementColor
            if counter == currentPage {
                elementFrame = CGRect(x: x, y: 0.0, width: selectedElementWidth, height: elementHeight)
                x += selectedElementWidth
            }
            else {
                elementFrame = CGRect(x: x, y: 0.0, width: elementWidth, height: elementHeight)
                theColor = elementColor
                x += elementWidth
            }
            x += elementSpacing
            let data = [self.kColor : theColor, self.kFrame : elementFrame] as [String : Any]
            returnArray.append(data)
            counter += 1
        }
        return returnArray
    }
    
    open func getColorFrameArrayOfItems(withFirstAnimatingIndex index1:Int, withVariation variation1:Double, NextAnimatingIndex index2:Int, withVariation variation2:Double) -> Array<Any> {
        var returnArray: Array<Any> = Array()
        var x: CGFloat = 0.0
        var counter = 0
        while counter < numberOfPages {
            var elementFrame = CGRect.zero
            var theColor: UIColor = selectedElementColor
            if counter == index2 {
                let theWidth:CGFloat = (selectedElementWidth - elementWidth) * CGFloat(variation2) + elementWidth
                elementFrame = CGRect(x: x, y: 0.0, width: theWidth, height: elementHeight)
                x += theWidth
            }
            else if counter == index1 {
                let theWidth:CGFloat = (selectedElementWidth - elementWidth) * CGFloat(variation1) + elementWidth
                elementFrame = CGRect(x: x, y: 0.0, width: theWidth, height: elementHeight)
                x += theWidth
            }
            else {
                elementFrame = CGRect(x: x, y: 0.0, width: elementWidth, height: elementHeight)
                theColor = elementColor
                x += elementWidth
            }
            x += elementSpacing
            let data = [self.kColor : theColor, self.kFrame : elementFrame] as [String : Any]
            returnArray.append(data)
            counter += 1
        }
        return returnArray
    }
}
