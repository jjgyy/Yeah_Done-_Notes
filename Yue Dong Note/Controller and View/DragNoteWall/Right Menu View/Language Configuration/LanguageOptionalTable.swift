//
//  LanguageOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class LanguageOptionalTable: RightMenuTable {

    init() {
        super.init(datas: AllLanguage.allLanguages)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        controller?.setLanguageThroughLanguageOptionalTable(cellIndex: indexPath.row)
    }

}
