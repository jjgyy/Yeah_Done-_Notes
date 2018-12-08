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
    
    var backgrounds = [String]()

    init(frame: CGRect, style: UITableView.Style, source: [String]) {
        super.init(frame: frame, style: style)
        self.backgrounds = source
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
    
    
}
