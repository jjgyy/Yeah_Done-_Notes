//
//  MemoryView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class MemoryView: RightMenuBranchView {

    var memoryLabel = RightMenuLabel(text: NSLocalizedString("Memory", comment: "回忆"))
    var newMemoryButton = RightMenuButton(text: "+  " + NSLocalizedString("New Memory", comment: "新的回忆"))
    var memoryTable = MemoryTable(memoryTableDatas: [TableData]())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(memoryLabel)
        addSubview(newMemoryButton)
        addSubview(memoryTable)
        
        newMemoryButton.addTarget(self, action: #selector(newMemory), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func newMemory() {
        controller?.saveNoteWall()
        if let newDatas = controller?.getNoteWallFileList() {
            memoryTable.datas = newDatas
            memoryTable.reloadData()
            memoryTable.setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        memoryLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        newMemoryButton.frame = CGRect(x: 0, y: 150, width: bounds.width, height: 45)
        memoryTable.frame = CGRect(x: 0.0, y: 220.0, width: Double(bounds.width), height: Double(memoryTable.datas.count) * 44.0)
    }

}
