//
//  RightMenuSubLabel.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/15.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuSubLabel: UILabel {

    init(text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 15.0)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
