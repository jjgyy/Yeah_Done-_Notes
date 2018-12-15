//
//  AllWallBackground.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/7.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation

struct AllWallBackground {
    
    static var allWallBackgrounds = [
        TableData(uiName: NSLocalizedString("illustration of leaves", comment: "树叶插画"), fileName: "illustration of leaves"),
        TableData(uiName: NSLocalizedString("reticule", comment: "手提袋"), fileName: "reticule"),
        TableData(uiName: NSLocalizedString("colorful furniture", comment: "多彩家居"), fileName: "colorful furniture"),
        TableData(uiName: NSLocalizedString("leaves art", comment: "树叶艺术"), fileName: "leaves art"),
        TableData(uiName: NSLocalizedString("ink", comment: "墨水"), fileName: "ink")
    ]
    
    static func reload() {
        AllWallBackground.allWallBackgrounds = [
            TableData(uiName: NSLocalizedString("illustration of leaves", comment: "树叶插画"), fileName: "illustration of leaves"),
            TableData(uiName: NSLocalizedString("reticule", comment: "手提袋"), fileName: "reticule"),
            TableData(uiName: NSLocalizedString("colorful furniture", comment: "多彩家居"), fileName: "colorful furniture"),
            TableData(uiName: NSLocalizedString("leaves art", comment: "树叶艺术"), fileName: "leaves art"),
            TableData(uiName: NSLocalizedString("ink", comment: "墨水"), fileName: "ink")
        ]
    }
    
}
