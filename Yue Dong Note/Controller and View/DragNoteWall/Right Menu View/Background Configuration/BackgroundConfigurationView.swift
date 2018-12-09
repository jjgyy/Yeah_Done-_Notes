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
    var backgroundOptionalTable = BackgroundOptionalTable()
    var controller: DragNoteViewController? {
        get {
            for view in sequence(first: self, next: { $0?.superview }) {
                if let responder = view.next {
                    if responder is DragNoteViewController{
                        return responder as? DragNoteViewController
                    }
                }
            }
            return nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundOptionalLabel)
        addSubview(backgroundOptionalTable)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundOptionalLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        backgroundOptionalTable.frame = CGRect(x: 0.0, y: 150.0, width: Double(bounds.width), height: Double(backgroundOptionalTable.backgrounds.count) * 44.0)
    }
    
    
}
