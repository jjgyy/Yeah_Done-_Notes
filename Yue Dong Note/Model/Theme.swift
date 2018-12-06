//
//  Theme.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/6.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation


struct Theme: Codable {
    
    var noteColor: NoteColor
    var noteFontSize: Float
    var noteWallBackground: String
    var noteNailImage: String
    
    struct NoteColor: Codable {
        var red: Float
        var green: Float
        var blue: Float
        var alpha: Float
        
        init(red: Float, green: Float, blue: Float, alpha: Float) {
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(noteColor: NoteColor, noteFontSize: Float, noteWallBackground: String, noteNailImage: String) {
        self.noteColor = noteColor
        self.noteFontSize = noteFontSize
        self.noteWallBackground = noteWallBackground
        self.noteNailImage = noteNailImage
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Theme.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
}
