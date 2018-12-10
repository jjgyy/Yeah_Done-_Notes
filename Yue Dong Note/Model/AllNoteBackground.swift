//
//  AllNoteBackground.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation

struct AllNoteBackground {
    
    static var allNoteBackgrounds = [
        TableData(uiName: NSLocalizedString("3D light yellow note", comment: "3D淡黄色便签"), fileName: "3D light yellow note"),
        TableData(uiName: NSLocalizedString("3D light pink note", comment: "3D淡粉色便签"), fileName: "3D light pink note")
    ]
    
    static func reload() {
        AllNoteBackground.allNoteBackgrounds = [
            TableData(uiName: NSLocalizedString("3D light yellow note", comment: "3D淡黄色便签"), fileName: "3D light yellow note"),
            TableData(uiName: NSLocalizedString("3D light pink note", comment: "3D淡粉色便签"), fileName: "3D light pink note")
        ]
    }
}
