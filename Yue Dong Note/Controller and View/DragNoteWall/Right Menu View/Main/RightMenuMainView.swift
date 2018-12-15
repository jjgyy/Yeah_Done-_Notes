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
    
    var functionLabel = RightMenuLabel(text: NSLocalizedString("Function", comment: "功能"))
        var shareButton = RightMenuButton(text: NSLocalizedString("Share", comment: "分享"))
        var recycleBinButton = RightMenuButton(text: NSLocalizedString("Recycle Bin", comment: "回收站"))
        var memoryButton = RightMenuButton(text: NSLocalizedString("Memory", comment: "回忆墙"))
    
    var systemConfigurationLabel = RightMenuLabel(text: NSLocalizedString("System", comment: "系统"))
        var languageConfigurationButton = RightMenuButton(text: NSLocalizedString("Language", comment: "语言"))
        var aboutButton = RightMenuButton(text: NSLocalizedString("About", comment: "关于"))


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(styleConfigurationLabel)
        
            addSubview(backgroundConfigurationButton)
            backgroundConfigurationButton.addTarget(self, action: #selector(toBackgroundConfigurationView), for: .touchUpInside)
        
            addSubview(fontConfigurationButton)
            fontConfigurationButton.addTarget(self, action: #selector(toFontConfigurationView), for: .touchUpInside)
        
            addSubview(noteBackgroundConfigurationButton)
            noteBackgroundConfigurationButton.addTarget(self, action: #selector(toNoteBackgroundConfigurationView), for: .touchUpInside)
        
        addSubview(functionLabel)
        
            addSubview(shareButton)
            shareButton.addTarget(self, action: #selector(toShareView), for: .touchUpInside)
        
            addSubview(recycleBinButton)
            recycleBinButton.addTarget(self, action: #selector(toRecycleBinView), for: .touchUpInside)
        
            addSubview(memoryButton)
            memoryButton.addTarget(self, action: #selector(toMemoryView), for: .touchUpInside)
        
        addSubview(systemConfigurationLabel)
        
            addSubview(languageConfigurationButton)
            languageConfigurationButton.addTarget(self, action: #selector(toLanguageConfigurationView), for: .touchUpInside)
        
            addSubview(aboutButton)
            aboutButton.addTarget(self, action: #selector(toAbout), for: .touchUpInside)
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
    
    @objc func toShareView() {
        rightMenuView?.toShare()
    }
    
    @objc func toRecycleBinView() {
        rightMenuView?.toRecycleBin()
    }
    
    @objc func toMemoryView() {
        rightMenuView?.toMemory()
    }
    
    @objc func toLanguageConfigurationView() {
        rightMenuView?.toLanguageConfiguration()
    }
    
    @objc func toAbout() {
        rightMenuView?.toAbout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleConfigurationLabel.frame = CGRect(x: 10, y: 35, width: bounds.width, height: 50)
            backgroundConfigurationButton.frame = CGRect(x: 0, y: 85, width: bounds.width, height: 45)
            fontConfigurationButton.frame = CGRect(x: 0, y: 130, width: bounds.width, height: 45)
            noteBackgroundConfigurationButton.frame = CGRect(x: 0, y: 175, width: bounds.width, height: 45)
        functionLabel.frame = CGRect(x: 10, y: 230, width: bounds.width, height: 50)
            memoryButton.frame = CGRect(x: 0, y: 280, width: bounds.width, height: 45)
            shareButton.frame = CGRect(x: 0, y: 325, width: bounds.width, height: 45)
            recycleBinButton.frame = CGRect(x: 0, y: 370, width: bounds.width, height: 45)
        systemConfigurationLabel.frame = CGRect(x: 10, y: 425, width: bounds.width, height: 50)
            languageConfigurationButton.frame = CGRect(x: 0, y: 475, width: bounds.width, height: 45)
            aboutButton.frame = CGRect(x: 0, y: 520, width: bounds.width, height: 45)
    }
    
}
