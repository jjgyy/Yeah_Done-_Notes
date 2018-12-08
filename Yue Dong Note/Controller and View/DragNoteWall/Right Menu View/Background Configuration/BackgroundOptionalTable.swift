//
//  BackgroundOptionalTable.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/7.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class BackgroundOptionalTable: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var indexOfCheckmarkedCell = 1
    var backgrounds = AllWallBackground.wallBackgrounds
    var controller: DragNoteViewController? {
        get {
            for view in sequence(first: self.superview, next: { $0?.superview }) {
                if let responder = view?.next {
                    if responder is DragNoteViewController{
                        return responder as? DragNoteViewController
                    }
                }
            }
            return nil
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.isScrollEnabled = false
        self.dataSource = self
        self.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backgrounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = backgrounds[indexPath.row]
        cell.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        let imageName = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        if let image = UIImage(named: imageName) {
            controller!.setWallBackgroundImageThroughBackgroundOptionalTable(image: image, cellIndex: indexPath.row)
        }
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
    
    
}
