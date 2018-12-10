//
//  NoteBackgroundOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class NoteBackgroundOptionalTable: RightMenuTable {
    
    init() {
        super.init(datas: AllNoteBackground.allNoteBackgrounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        controller?.setNoteBackgroundThroughNoteBackgroundOptionalTable(cellIndex: indexPath.row)
    }

}
