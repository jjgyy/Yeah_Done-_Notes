//
//  BackgroundOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/7.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class BackgroundOptionalTable: RightMenuTable {
    
    init() {
        super.init(datas: AllWallBackground.allWallBackgrounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        controller?.setWallBackgroundImageThroughBackgroundOptionalTable(cellIndex: indexPath.row)
    }
        
    
}
