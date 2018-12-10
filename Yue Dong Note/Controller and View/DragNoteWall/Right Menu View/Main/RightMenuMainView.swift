//
//  RightMenuMainView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuMainView: UIView {
    
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
    
    var styleConfigurationLabel = RightMenuLabel(text: NSLocalizedString("Style", comment: "样式"))
        var backgroundConfigurationButton = RightMenuButton(text: NSLocalizedString("Background", comment: "背景"))
        var fontConfigurationButton = RightMenuButton(text: NSLocalizedString("Font", comment: "字体"))
        var noteBackgroundConfigurationButton = RightMenuButton(text: NSLocalizedString("Note Style", comment: "便签样式"))
    
    var systemConfigurationLabel = RightMenuLabel(text: NSLocalizedString("System", comment: "系统"))
        var languageConfigurationButton = RightMenuButton(text: NSLocalizedString("Language", comment: "语言"))
    

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
        
            addSubview(languageConfigurationButton)
            languageConfigurationButton.addTarget(self, action: #selector(toLanguageConfigurationView), for: .touchUpInside)
        
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
    
    @objc func toLanguageConfigurationView() {
        rightMenuView?.toLanguageConfiguration()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleConfigurationLabel.frame = CGRect(x: 10, y: 35, width: bounds.width, height: 50)
            backgroundConfigurationButton.frame = CGRect(x: 0, y: 85, width: bounds.width, height: 45)
            fontConfigurationButton.frame = CGRect(x: 0, y: 130, width: bounds.width, height: 45)
            noteBackgroundConfigurationButton.frame = CGRect(x: 0, y: 175, width: bounds.width, height: 45)
        systemConfigurationLabel.frame = CGRect(x: 10, y: 230, width: bounds.width, height: 50)
            languageConfigurationButton.frame = CGRect(x: 0, y: 280, width: bounds.width, height: 45)
    }
    
}
