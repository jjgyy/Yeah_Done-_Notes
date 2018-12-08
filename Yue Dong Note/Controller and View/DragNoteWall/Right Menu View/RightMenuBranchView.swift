//
//  RightMenuBranchView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuBranchView: UIView {
    
    var backButton = UIButton(type: UIButton.ButtonType.contactAdd)
    var rightMenuView: RightMenuView? {
        get {
            for view in sequence(first: self, next: { $0?.superview }) {
                if view is RightMenuView {
                    return view as? RightMenuView
                }
            }
            return nil
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backButton)
        backButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func goBack() {
        rightMenuView?.toMain()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.frame = CGRect(x: 0.0, y: 10.0, width: 100.0, height: 100.0)
    }
    
}