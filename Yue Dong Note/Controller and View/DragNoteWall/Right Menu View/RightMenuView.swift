//
//  RightMenuView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/7.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuView: UIView {
    
    var currentSubview: UIView?
    var rightMenuMainView = RightMenuMainView()
    var backgroundConfigurationView = BackgroundConfigurationView()
    var controller: DragNoteViewController? {
        get {
            for view in sequence(first: self, next: { $0?.superview }) {
                if let responder = view.next {
                    if responder is DragNoteViewController{
                        return responder as? DragNoteViewController
                    }
                }
            }
            return nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.95)
        addSwipeGes()
        layer.masksToBounds = true
        
        addSubview(rightMenuMainView)
        addSubview(backgroundConfigurationView)
        currentSubview = rightMenuMainView
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addSwipeGes() {
        let swipeTheMenuGesRec = UISwipeGestureRecognizer(target: self, action: #selector(swipTheMenuGesAction(_:)))
        swipeTheMenuGesRec.direction = .right
        addGestureRecognizer(swipeTheMenuGesRec)
    }
    @objc func swipTheMenuGesAction( _ sender : UISwipeGestureRecognizer) {
        controller?.hideRightMenuView()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightMenuMainView.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
        backgroundConfigurationView.frame = CGRect(x: bounds.width, y: 0.0, width: bounds.width, height: bounds.height)
        currentSubview = rightMenuMainView
    }
    
    func toMain() {
        transitionAnimationFromLeft(to: rightMenuMainView)
    }
    
    func toBackgroundConfiguration() {
        transitionAnimationFromRight(to: backgroundConfigurationView)
    }
    
    func transitionAnimationFromLeft(to view: UIView) {
        view.frame.origin.x = -(self.bounds.width)
        UIView.animate(withDuration: 0.2) {
            self.currentSubview?.frame.origin.x = self.bounds.width
            view.frame.origin.x = 0.0
        }
        currentSubview = view
    }
    
    func transitionAnimationFromRight(to view: UIView) {
        view.frame.origin.x = self.bounds.width
        UIView.animate(withDuration: 0.2) {
            self.currentSubview?.frame.origin.x = -(self.bounds.width)
            view.frame.origin.x = 0.0
        }
        currentSubview = view
    }

}
