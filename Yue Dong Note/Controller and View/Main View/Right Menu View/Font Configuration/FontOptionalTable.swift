//
//  FontOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class FontOptionalTable: RightMenuTable {
    
    init() {
        super.init(datas: AllFont.allFonts)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row].uiName
        cell.textLabel?.font = UIFont(name: AllFont.allFonts[indexPath.row].fileName, size: CGFloat(AllFont.allFontsRelativeSize[indexPath.row]))
        cell.textLabel?.textColor = UIColor(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        controller?.setFontThroughBackgroundOptionalTable(cellIndex: indexPath.row)
    }
    
}
