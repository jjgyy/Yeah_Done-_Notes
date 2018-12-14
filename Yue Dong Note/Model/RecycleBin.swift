//
//  RecycleBin.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/11.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation

struct RecycleBin: Codable {
    
    var deletedNotes = [Note]()
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init() {}
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(RecycleBin.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    mutating func add(_ note: Note) {
        deletedNotes.insert(note, at: 0)
        if deletedNotes.count > 10 {
            deletedNotes.remove(at: 10)
        }
    }
    
    mutating func remove(index: Int) {
        deletedNotes.remove(at: index)
    }
    
    func toTableDatas() -> [TableData] {
        var tableDatas = [TableData]()
        for note in deletedNotes {
            //let index = note.text.index(note.text.startIndex, offsetBy: 10)
            tableDatas.append(TableData(uiName: note.text, fileName: ""))
        }
        return tableDatas
    }
    
}
