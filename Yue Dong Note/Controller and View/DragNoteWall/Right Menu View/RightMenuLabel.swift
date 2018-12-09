//
//  RightMenuLabel.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuLabel: UILabel {

    init(text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 20.0)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
