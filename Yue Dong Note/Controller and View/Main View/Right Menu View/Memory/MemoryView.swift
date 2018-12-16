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
    var countLabel = RightMenuSubLabel(text: "")
    var memoryTable = MemoryTable(memoryTableDatas: [TableData]())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(memoryLabel)
        addSubview(newMemoryButton)
        addSubview(countLabel)
        addSubview(memoryTable)
        
        newMemoryButton.addTarget(self, action: #selector(newMemory), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func newMemory() {
        if memoryTable.datas.count < 10 {
            controller?.addCreatingMemoryNum()
            controller?.addNewMemoryThroughRightMenu()
        }
    }
    
    func updateCountLabel() {
        countLabel.text = "\(memoryTable.datas.count) / 10"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        memoryLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        newMemoryButton.frame = CGRect(x: 0, y: 150, width: bounds.width, height: 45)
        countLabel.frame = CGRect(x: 10, y: 200, width: bounds.width, height: 45)
        memoryTable.frame = CGRect(x: 0.0, y: 245.0, width: Double(bounds.width), height: Double(memoryTable.datas.count) * 44.0)
        memoryTable.isScrollEnabled = false
        //适配低分辨率手机
        if let rootViewHeight = controller?.rootView.bounds.height {
            if memoryTable.frame.origin.y + memoryTable.frame.height > rootViewHeight {
                memoryTable.frame.size.height = rootViewHeight - memoryTable.frame.origin.y
                memoryTable.isScrollEnabled = true
            }
        }
    }

}
