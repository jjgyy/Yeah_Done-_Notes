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

    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return NSLocalizedString("Delete", comment: "删除")
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller?.recycleBin.remove(index: indexPath.row)
            controller?.saveRecycleBin()
            reloadDataAndLayout()
        }
    }
    
    func reloadDataAndLayout() {
        if let newDatas = controller?.recycleBin.toTableDatas() {
            datas = newDatas
            reloadData()
            superview?.setNeedsLayout()
        }
    }
    
}
