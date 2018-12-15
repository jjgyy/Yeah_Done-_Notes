//
//  AllFont.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation

struct AllFont {
    
    static var allFonts = [
        TableData(uiName: NSLocalizedString("fine pen smooth", comment: "细钢笔圆滑"), fileName: "HYShiGuangTiW"),
        TableData(uiName: NSLocalizedString("fine pen handwriting", comment: "细钢笔手写"), fileName: "AaTaoTaoti"),
        TableData(uiName: NSLocalizedString("chalk handwriting", comment: "粉笔手写"), fileName: "SentyChalkOriginal")
    ]
    
    static var allFontsRelativeSize = [
        18.0,
        17.0,
        12.0
    ]
    
    static func reload() {
        AllFont.allFonts = [
            TableData(uiName: NSLocalizedString("fine pen smooth", comment: "细钢笔圆滑"), fileName: "HYShiGuangTiW"),
            TableData(uiName: NSLocalizedString("fine pen handwriting", comment: "细钢笔手写"), fileName: "AaTaoTaoti"),
            TableData(uiName: NSLocalizedString("chalk handwriting", comment: "粉笔手写"), fileName: "SentyChalkOriginal")
        ]
    }
    
}
