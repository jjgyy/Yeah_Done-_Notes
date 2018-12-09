//
//  RightMenuMainView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuMainView: UIView {
    
    var styleConfigurationLabel = RightMenuLabel(text: NSLocalizedString("Style", comment: "样式"))
        var backgroundConfigurationButton = RightMenuButton(text: NSLocalizedString("Background", comment: "背景"))
        var fontConfigurationButton = RightMenuButton(text: NSLocalizedString("Font", comment: "字体"))
        var noteBackgroundConfigurationButton = RightMenuButton(text: NSLocalizedString("Note Style", comment: "便签样式"))
    
    var systemConfigurationLabel = RightMenuLabel(text: NSLocalizedString("System", comment: "系统"))
    
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
        
            addSubview(backgroundConfigurationButton)
            backgroundConfigurationButton.addTarget(self, action: #selector(toBackgroundConfigurationView), for: .touchUpInside)
        
            addSubview(fontConfigurationButton)
            fontConfigurationButton.addTarget(self, action: #selector(toFontConfigurationView), for: .touchUpInside)
        
            addSubview(noteBackgroundConfigurationButton)
            noteBackgroundConfigurationButton.addTarget(self, action: #selector(toNoteBackgroundConfigurationView), for: .touchUpInside)
        
        addSubview(systemConfigurationLabel)
        
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
    
    @objc func toNoteBackgroundConfigurationView() {
        rightMenuView?.toNoteBackgroundConfiguration()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleConfigurationLabel.frame = CGRect(x: 10.0, y: 35.0, width: bounds.width, height: 50.0)
            backgroundConfigurationButton.frame = CGRect(x: 0.0, y: 85.0, width: bounds.width, height: 45.0)
            fontConfigurationButton.frame = CGRect(x: 0.0, y: 130.0, width: bounds.width, height: 45.0)
            noteBackgroundConfigurationButton.frame = CGRect(x: 0.0, y: 175.0, width: bounds.width, height: 45.0)
        systemConfigurationLabel.frame = CGRect(x: 10.0, y: 230.0, width: bounds.width, height: 50.0)
    }
    
}
