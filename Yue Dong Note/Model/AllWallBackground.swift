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
        TableData(uiName: NSLocalizedString("illustration of leaves", comment: "淡雅树叶插画"), fileName: "illustration of leaves"),
        TableData(uiName: NSLocalizedString("frosty window", comment: "雾窗"), fileName: "frosty window"),
        TableData(uiName: NSLocalizedString("ink", comment: "墨水"), fileName: "ink")
    ]
    
    static func reload() {
        AllWallBackground.allWallBackgrounds = [
            TableData(uiName: NSLocalizedString("illustration of leaves", comment: "淡雅树叶插画"), fileName: "illustration of leaves"),
            TableData(uiName: NSLocalizedString("frosty window", comment: "雾窗"), fileName: "frosty window"),
            TableData(uiName: NSLocalizedString("ink", comment: "墨水"), fileName: "ink")
        ]
    }
    
}
