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
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return NSLocalizedString("Delete", comment: "删除")
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller?.deleteNoteWall(fileName: datas[indexPath.row].fileName)
            if let newDatas = controller?.getNoteWallFileList() {
                datas = newDatas
                reloadData()
                setNeedsLayout()
            }
        }
    }
    


}
