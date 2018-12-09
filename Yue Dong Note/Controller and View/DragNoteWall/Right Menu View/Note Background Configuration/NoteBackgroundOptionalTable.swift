//
//  NoteBackgroundOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class NoteBackgroundOptionalTable: RightMenuTable {

    var noteBackgrounds = AllNoteBackground.allNoteBackgrounds
    
    init() {
        super.init(datas: noteBackgrounds)
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
