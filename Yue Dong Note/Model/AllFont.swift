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
        TableData(uiName: NSLocalizedString("fine pen handwriting", comment: "细钢笔潦草"), fileName: "AaTaoTaoti"),
        TableData(uiName: NSLocalizedString("marker pen printed", comment: "马克笔帅线体"), fileName: "HYShuaiXianTiW"),
        TableData(uiName: NSLocalizedString("apple jianfang", comment: "苹果简方"), fileName: "PingFangSC-Medium"),
        TableData(uiName: NSLocalizedString("bold marker printed", comment: "粗马克简黑体"), fileName: "FZJHJW--GB1-0"),
        TableData(uiName: NSLocalizedString("bold marker cute", comment: "粗马克跳跳体"), fileName: "HYTiaoTiaoTiJ"),
        TableData(uiName: NSLocalizedString("bold pen handwriting", comment: "粗钢笔手写"), fileName: "AaJoe"),
        TableData(uiName: NSLocalizedString("square printed", comment: "方块印刷体"), fileName: "FZMINGSTJW--GB1-0")
    ]
    
    static var allFontsRelativeSize = [
        18.0,
        17.0,
        17.0,
        15.0,
        18.0,
        18.0,
        17.0,
        16.0
    ]
    
    static func reload() {
        AllFont.allFonts = [
            TableData(uiName: NSLocalizedString("fine pen smooth", comment: "细钢笔圆滑"), fileName: "HYShiGuangTiW"),
            TableData(uiName: NSLocalizedString("fine pen handwriting", comment: "细钢笔潦草"), fileName: "AaTaoTaoti"),
            TableData(uiName: NSLocalizedString("marker pen printed", comment: "马克笔帅线体"), fileName: "HYShuaiXianTiW"),
            TableData(uiName: NSLocalizedString("apple jianfang", comment: "苹果简方"), fileName: "PingFangSC-Medium"),
            TableData(uiName: NSLocalizedString("bold marker printed", comment: "粗马克简黑体"), fileName: "FZJHJW--GB1-0"),
            TableData(uiName: NSLocalizedString("bold marker cute", comment: "粗马克跳跳体"), fileName: "HYTiaoTiaoTiJ"),
            TableData(uiName: NSLocalizedString("bold pen handwriting", comment: "粗钢笔手写"), fileName: "AaJoe"),
            TableData(uiName: NSLocalizedString("square printed", comment: "方块印刷体"), fileName: "FZMINGSTJW--GB1-0")
        ]
    }
    
}
