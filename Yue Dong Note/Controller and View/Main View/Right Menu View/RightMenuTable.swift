//
//  RightMenuTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuTable: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var datas = [TableData]()
    var indexOfCheckmarkedCell = 0
    var controller: DragNoteViewController? {
        get {
            for view in sequence(first: self, next: { $0?.superview }) {
                if let responder = view.next {
                    if responder is DragNoteViewController{
                        return responder as? DragNoteViewController
                    }
                }
            }
            return nil
        }
    }

    init(datas: [TableData]) {
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
        self.datas = datas
        self.isScrollEnabled = false
        self.dataSource = self
        self.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row].uiName
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.textLabel?.textColor = UIColor(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func markTheCellNeedingMarked() {
        if indexPathsForVisibleRows != nil {
            for indexPath in indexPathsForVisibleRows! {
                if indexPath.row == indexOfCheckmarkedCell {
                    cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                } else {
                    cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    }
    

}
