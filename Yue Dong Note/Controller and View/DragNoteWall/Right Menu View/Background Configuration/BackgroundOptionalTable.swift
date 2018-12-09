//
//  BackgroundOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/7.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class BackgroundOptionalTable: RightMenuTable {
    
    var backgrounds = AllWallBackground.wallBackgrounds
    
    
    init() {
        super.init(datas: backgrounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        let imageFileName = backgrounds[indexPath.row].fileName
        if let image = UIImage(named: imageFileName) {
            controller!.setWallBackgroundImageThroughBackgroundOptionalTable(image: image, cellIndex: indexPath.row)
        }
    }
    
    
}
