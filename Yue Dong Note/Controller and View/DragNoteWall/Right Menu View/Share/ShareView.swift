//
//  ShareView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/14.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class ShareView: RightMenuBranchView {

    var shareLabel = RightMenuLabel(text: NSLocalizedString("Share", comment: "分享"))
    var shareScreenshotButton = RightMenuButton(text: NSLocalizedString("Share Screenshot", comment: "分享当前便签墙"))
    //var shareTable = ShareTable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(shareLabel)
        addSubview(shareScreenshotButton)
        shareScreenshotButton.addTarget(self, action: #selector(shareScreenshot), for: .touchUpInside)
        //addSubview(shareTable)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func shareScreenshot() {
        controller?.shareScreenOnSocialPlatform()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shareLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        shareScreenshotButton.frame = CGRect(x: 0, y: 150, width: bounds.width, height: 45)
        //shareTable.frame = CGRect(x: 0.0, y: 150.0, width: Double(bounds.width), height: Double(shareTable.datas.count) * 44.0)
    }

}
