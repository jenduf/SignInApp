//
//  ContentScrollView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol ContentScrollViewDelegate
{
    func contentDidScrollToPage(page: Int)
}

class ContentScrollView: UIScrollView
{
    
    @IBOutlet var contentView: UIView!

    var contentDelegate: ContentScrollViewDelegate?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.delegate = self
        
        self.scrollEnabled = false
        
       // self.decelerationRate = UIScrollViewDecelerationRateFast
        
        //self.panGestureRecognizer.delegate = self
    }
    
   /* override func scrollRectToVisible(rect: CGRect, animated: Bool)
    {
        
    }
    
    override func setContentOffset(contentOffset: CGPoint, animated: Bool)
    {
        super.setContentOffset(contentOffset, animated: animated)
    }*/
    
    func centerScrollView()
    {
        let page = self.contentOffset.x / self.frame.width //+ ((Constants.SIDE_PADDING * 2) + (Constants.CONTAINER_PADDING * 2)))
        
        self.setContentOffset(CGPoint(x: self.contentOffset.x + (page * Constants.Layout.CONTAINER_SPACING), y: 0), animated: false)
        print("new scroll offset: \(self.contentOffset)")
    }

}

/*
extension ContentScrollView: UIGestureRecognizerDelegate
{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        let gestureView = gestureRecognizer.view
        
        let otherGestureView = otherGestureRecognizer.view
        
        print("GESTURE: \(gestureView) OTHER GESTURE: \(otherGestureView)")
        
        if gestureView?.isMemberOfClass(UIScrollView) == false || otherGestureView?.isMemberOfClass(UIScrollView) == false
        {
            return true
        }
        
        return false
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        let gestureView = gestureRecognizer.view
        
        return true
    }
}*/

extension ContentScrollView: UIScrollViewDelegate
{
   /* override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }*/
    
    override func touchesShouldBegin(touches: Set<UITouch>, withEvent event: UIEvent?, inContentView view: UIView) -> Bool
    {
        if view.isKindOfClass(FormTextField.self) || view.isKindOfClass(CanvasView.self) || view.isKindOfClass(UIButton.self)
        {
            return true
        }
        
        return false
    }
    
    override func touchesShouldCancelInContentView(view: UIView) -> Bool
    {
        return true
    }
  
    /*
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if self.scrollEnabled == false
        {
            print("UH UH UH NO SCROLL")
            self.centerScrollView()
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let index = targetContentOffset. / scrollView.frame.width
        
        
        
    }*/
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        /*let page = scrollView.contentOffset.x / scrollView.frame.width //+ ((Constants.SIDE_PADDING * 2) + (Constants.CONTAINER_PADDING * 2)))
        
       // scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + (page * Constants.Layout.CONTAINER_SPACING), y: 0), animated: true)
        print("new scroll offset: \(scrollView.contentOffset)")
        */
        
       // self.centerScrollView()
        
        let page = scrollView.contentOffset.x / scrollView.frame.width
        self.contentDelegate?.contentDidScrollToPage(Int(page))
    }
}
