//
//  RootView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/8.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RootView: UIView {
    
    var rightMenuView = RightMenuView()
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
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let rightEdgePanGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(rightEdgePanAction(_:)))
        rightEdgePanGes.edges = .right
        addGestureRecognizer(rightEdgePanGes)
        addSubview(rightMenuView)
    }
    @objc func rightEdgePanAction( _ sender : UIScreenEdgePanGestureRecognizer) {
        if (sender.state == UIScreenEdgePanGestureRecognizer.State.began) {
            controller?.showRightMenuView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightMenuView.frame = CGRect(x: bounds.width, y: 0, width: 240.0, height: bounds.height)
    }
    
    func showRightMenu() {
        bringSubviewToFront(rightMenuView)
        UIView.animate(withDuration: 0.2) {
            self.rightMenuView.frame.origin.x = self.bounds.width - self.rightMenuView.frame.width
        }
    }
    
    func hideRightMenu() {
        UIView.animate(withDuration: 0.2) {
            self.rightMenuView.frame.origin.x = self.bounds.width
        }
    }
    
    func reloadRightMenu() {

        UIView.animate(withDuration: 0.2, animations: {self.rightMenuView.frame.origin.x = self.bounds.width}, completion: {_ in
            self.rightMenuView.removeFromSuperview()
            self.rightMenuView = RightMenuView()
            self.addSubview(self.rightMenuView)
        })
        
    }

}
