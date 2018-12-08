//
//  RightMenuMainView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuMainView: UIView {
    
    var backgroundConfigurationButton = UIButton(type: UIButton.ButtonType.contactAdd)
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
        addSubview(backgroundConfigurationButton)
        backgroundConfigurationButton.addTarget(self, action: #selector(toBackgroundConfigurationView), for: UIControl.Event.touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func toBackgroundConfigurationView() {
        rightMenuView?.toBackgroundConfiguration()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundConfigurationButton.frame = CGRect(x: 0.0, y: 20.0, width: 100.0, height: 50.0)
    }
    
}
