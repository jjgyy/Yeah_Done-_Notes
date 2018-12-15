//
//  AboutView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/14.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class AboutView: RightMenuBranchView {

    var aboutLabel = RightMenuLabel(text: NSLocalizedString("About", comment: "关于"))
    var appNameButton = RightMenuButton(text: NSLocalizedString("App Name", comment: "应用名"), info: "1.0.0")
    
    var statisticsLabel = RightMenuLabel(text: NSLocalizedString("Statistics", comment: "统计"))
    var creatingNotesNumButton = RightMenuButton(text: NSLocalizedString("creating number", comment: "便签数量"), info: "")
    var creatingMemoryNumButton = RightMenuButton(text: NSLocalizedString("creating memory number", comment: ""), info: "")
    
    func updateStatistics() {
        if let creatingNotesNum = controller?.creatingNotesNum {
            creatingNotesNumButton.infoLabel.text = String(creatingNotesNum)
        }
        if let creatingMemoryNum = controller?.creatingMemoryNum {
            creatingMemoryNumButton.infoLabel.text = String(creatingMemoryNum)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(aboutLabel)
        addSubview(appNameButton)
        addSubview(statisticsLabel)
        addSubview(creatingNotesNumButton)
        addSubview(creatingMemoryNumButton)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aboutLabel.frame = CGRect(x: 10, y: 100, width: bounds.width, height: 50)
        appNameButton.frame = CGRect(x: 0, y: 150, width: bounds.width, height: 45)
        statisticsLabel.frame = CGRect(x: 10, y: 220, width: bounds.width, height: 50)
        creatingNotesNumButton.frame = CGRect(x: 0, y: 270, width: bounds.width, height: 45)
        creatingMemoryNumButton.frame = CGRect(x: 0, y: 315, width: bounds.width, height: 45)
//        if let notesNum = controller?.creatingNotesNum {
//            creatingNotesNum = notesNum
//        }
    }
    
}
