//
//  Recycle Bin.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RecycleBinView: RightMenuBranchView {

    var recycleBinLabel = RightMenuLabel(text: NSLocalizedString("Recycle Bin", comment: "回收站"))
    var recycleBinTable = RecycleBinTable(recycleBinTableDatas: [TableData]())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recycleBinLabel)
        addSubview(recycleBinTable)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recycleBinLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        recycleBinTable.frame = CGRect(x: 0.0, y: 150.0, width: Double(bounds.width), height: Double(recycleBinTable.datas.count) * 44.0)
    }

}
