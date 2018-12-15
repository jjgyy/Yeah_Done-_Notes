//
//  MemoryTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class MemoryTable: RightMenuTable {

    init(memoryTableDatas: [TableData]) {
        super.init(datas: memoryTableDatas)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.watchMemoryThroughRightMenu(fileName: datas[indexPath.row].fileName)
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return NSLocalizedString("Delete", comment: "删除")
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller?.deleteMemoryFromFileSystem(fileName: datas[indexPath.row].fileName)
            reloadDataAndLayout()
        }
    }
    
    func reloadDataAndLayout() {
        if let newDatas = controller?.getMemoryFileList() {
            datas = newDatas
            reloadData()
            setNeedsLayout()
        }
    }
    


}
