//
//  BackgroundConfigurationView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class BackgroundConfigurationView: RightMenuBranchView {
    
    var backgroundOptionalLabel = UILabel()
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
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.95)
        backgroundOptionalLabel.text = "背景"
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundOptionalTable.frame = CGRect(x: 0.0, y: 100.0, width: bounds.width, height: 240.0)
        backgroundOptionalLabel.frame = CGRect(x: 10.0, y: 50.0, width: 100.0, height: 50.0)
    }
    
    
}
