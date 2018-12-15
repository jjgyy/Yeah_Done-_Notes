//
//  BackgroundConfigurationView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class BackgroundConfigurationView: RightMenuBranchView {
    
    var backgroundOptionalLabel = RightMenuLabel(text: NSLocalizedString("Background", comment: "背景"))
    var customizeButton = RightMenuButton(text: NSLocalizedString("Customize", comment: "自定义") + "...")
    var backgroundOptionalTable = BackgroundOptionalTable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundOptionalLabel)
        addSubview(customizeButton)
        customizeButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        addSubview(backgroundOptionalTable)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func pickImage() {
        controller?.pickImageForWallBackground()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundOptionalLabel.frame = CGRect(x: 10, y: 100, width: bounds.width, height: 50)
        customizeButton.frame = CGRect(x: 0, y: 150, width: bounds.width, height: 45)
        backgroundOptionalTable.frame = CGRect(x: 0, y: 210, width: Double(bounds.width), height: Double(backgroundOptionalTable.datas.count) * 44.0)
    }
    
    
}
