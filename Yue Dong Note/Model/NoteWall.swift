//
//  NoteWall.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/5.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation

struct NoteWall: Codable {
    
    var notes: [Note]
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init() {
        self.notes = [Note]()
    }
    
    init(notes: [Note]) {
        self.notes = notes
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(NoteWall.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
}
