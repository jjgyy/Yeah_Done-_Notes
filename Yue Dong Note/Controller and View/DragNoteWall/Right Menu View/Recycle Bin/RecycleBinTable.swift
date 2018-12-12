//
//  RecycleBinTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RecycleBinTable: RightMenuTable {

    init(recycleBinTableDatas: [TableData]) {
        super.init(datas: recycleBinTableDatas)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.createNoteThroughRecycleBinTable(cellIndex: indexPath.row)
    }

    
}
