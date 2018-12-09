//
//  RightMenuMainView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuMainView: UIView {
    
    var styleConfigurationLabel = UILabel()
    var backgroundConfigurationButton = RightMenuButton(text: "背景")
    var fontConfigurationButton = RightMenuButton(text: "字体")
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
        addSubview(styleConfigurationLabel)
        styleConfigurationLabel.text = "样式"
        
        addSubview(backgroundConfigurationButton)
        backgroundConfigurationButton.addTarget(self, action: #selector(toBackgroundConfigurationView), for: UIControl.Event.touchUpInside)
        
        addSubview(fontConfigurationButton)
        fontConfigurationButton.addTarget(self, action: #selector(toFontConfigurationView), for: UIControl.Event.touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func toBackgroundConfigurationView() {
        rightMenuView?.toBackgroundConfiguration()
    }
    
    @objc func toFontConfigurationView() {
        rightMenuView?.toFontConfiguration()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleConfigurationLabel.frame = CGRect(x: 10.0, y: 35.0, width: bounds.width, height: 50.0)
        backgroundConfigurationButton.frame = CGRect(x: 0.0, y: 80.0, width: bounds.width, height: 45.0)
        fontConfigurationButton.frame = CGRect(x: 0.0, y: 125.0, width: bounds.width, height: 45.0)
    }
    
}
