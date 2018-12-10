//
//  AllLanguage.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation

struct AllLanguage {
    static var allLanguages = [
        TableData(uiName: "English", fileName: "en"),
        TableData(uiName: "简体中文", fileName: "zh-Hans"),
        TableData(uiName: "繁體中文", fileName: "zh-Hant"),
        TableData(uiName: "日本語", fileName: "ja")
    ]
    
    static func reload() {
        AllLanguage.allLanguages = [
            TableData(uiName: "English", fileName: "en"),
            TableData(uiName: "简体中文", fileName: "zh-Hans"),
            TableData(uiName: "繁體中文", fileName: "zh-Hant"),
            TableData(uiName: "日本語", fileName: "ja")
        ]
    }
    
}
