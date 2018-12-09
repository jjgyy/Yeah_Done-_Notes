//
//  Theme.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/6.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation


struct Theme: Codable {
    
    var noteFontTableIndex = 0
    var noteBackgroundTableIndex = 0
    var noteWallBackgroundTableIndex = 0
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init() {
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Theme.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
}
