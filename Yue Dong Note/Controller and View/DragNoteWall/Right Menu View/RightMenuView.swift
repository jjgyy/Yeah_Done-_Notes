//
//  RightMenuView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/7.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuView: UIView {
    
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

    var currentSubview: UIView?
    
    
    //--------------------------------菜单选项配置-------------------------------
    
    var rightMenuMainView = RightMenuMainView()
    var backgroundConfigurationView = BackgroundConfigurationView()
    var fontConfigurationView = FontConfigurationView()
    var noteBackgroundConfigurationView = NoteBackgroundConfigurationView()
    var languageConfigurationView = LanguageConfigurationView()
    var recycleBinView = RecycleBinView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.95)
        addSwipeGes()
        layer.masksToBounds = true
        
        addSubview(rightMenuMainView)
        addSubview(backgroundConfigurationView)
        addSubview(fontConfigurationView)
        addSubview(noteBackgroundConfigurationView)
        addSubview(languageConfigurationView)
        addSubview(recycleBinView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func toMain() {
        transitionAnimationFromLeft(to: rightMenuMainView)
    }
    
    func toBackgroundConfiguration() {
        backgroundConfigurationView.backgroundOptionalTable.markTheCellNeedingMarked()
        transitionAnimationFromRight(to: backgroundConfigurationView)
    }
    
    func toFontConfiguration() {
        fontConfigurationView.fontOptionalTable.markTheCellNeedingMarked()
        transitionAnimationFromRight(to: fontConfigurationView)
    }
    
    func toNoteBackgroundConfiguration() {
        noteBackgroundConfigurationView.noteBackgroundOptionalTable.markTheCellNeedingMarked()
        transitionAnimationFromRight(to: noteBackgroundConfigurationView)
    }
    
    func toLanguageConfiguration() {
        languageConfigurationView.languageOptionalTable.markTheCellNeedingMarked()
        transitionAnimationFromRight(to: languageConfigurationView)
    }
    
    func toRecycleBin() {
        if let datas = controller?.recycleBin.toTableDatas() {
            recycleBinView.recycleBinTable.removeFromSuperview()
            recycleBinView.recycleBinTable = RecycleBinTable(recycleBinTableDatas: datas)
            recycleBinView.addSubview(recycleBinView.recycleBinTable)
            recycleBinView.setNeedsLayout()
        }
        transitionAnimationFromRight(to: recycleBinView)
    }
    
    //-----------------------------------------------------------------------
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rightMenuMainView.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
        currentSubview = rightMenuMainView
        
        for view in subviews {
            if view is RightMenuBranchView {
                (view as! RightMenuBranchView).frame = CGRect(x: bounds.width, y: 0.0, width: bounds.width, height: bounds.height)
            }
        }
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
    
    
    
    func addSwipeGes() {
        let swipeTheMenuGesRec = UISwipeGestureRecognizer(target: self, action: #selector(swipTheMenuGesAction(_:)))
        swipeTheMenuGesRec.direction = .right
        addGestureRecognizer(swipeTheMenuGesRec)
    }
    @objc func swipTheMenuGesAction( _ sender : UISwipeGestureRecognizer) {
        controller?.hideRightMenuView()
    }
    
    

}
