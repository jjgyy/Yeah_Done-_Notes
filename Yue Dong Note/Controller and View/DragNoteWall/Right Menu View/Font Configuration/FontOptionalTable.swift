//
//  FontOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class FontOptionalTable: RightMenuTable {
    
    var fonts = AllFont.allFonts
    
    init() {
        super.init(datas: fonts)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        let fontFileName = fonts[indexPath.row].fileName
        controller?.setFontThroughBackgroundOptionalTable(fontName: fontFileName, cellIndex: indexPath.row)
    }
    
}
