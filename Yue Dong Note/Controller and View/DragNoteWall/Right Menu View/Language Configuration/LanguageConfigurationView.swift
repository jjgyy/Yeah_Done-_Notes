//
//  LanguageConfigurationView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class LanguageConfigurationView: RightMenuBranchView {

    var languageOptionalLabel = RightMenuLabel(text: NSLocalizedString("Language", comment: "语言"))
    var languageOptionalTable = LanguageOptionalTable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(languageOptionalLabel)
        addSubview(languageOptionalTable)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        languageOptionalLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        languageOptionalTable.frame = CGRect(x: 0.0, y: 150.0, width: Double(bounds.width), height: Double(languageOptionalTable.datas.count) * 44.0)
    }

}
