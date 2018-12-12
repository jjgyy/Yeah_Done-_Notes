//
//  Note.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/5.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation
import UIKit


struct Note: Codable {
    
    var identifier = Date().timeIntervalSince1970
    var text: String
    var frame = NoteFrame()

    struct NoteFrame: Codable {
        var x: Float = Float()
        var y: Float = Float()
        var width: Float = Float()
        var height: Float = Float()
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Note.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    init(text: String) {
        self.text = text
    }
    
    init(text: String, x: Float, y: Float) {
        self.text = text
        self.frame.x = x
        self.frame.y = y
    }
    
    init(text: String, width: Float, height: Float, x: Float, y: Float) {
        self.text = text
        self.frame.width = width
        self.frame.height = height
        self.frame.x = x
        self.frame.y = y
    }
    
    init(identifier: TimeInterval, text: String, frame: CGRect) {
        self.identifier = identifier
        self.text = text
        self.frame.x = Float(frame.origin.x)
        self.frame.y = Float(frame.origin.y)
        self.frame.width = Float(frame.width)
        self.frame.height = Float(frame.height)
    }
    
}
