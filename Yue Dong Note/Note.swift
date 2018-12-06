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
    
    var identifier = NSTimeIntervalSince1970
    var text: String
    var fontSize: Float = 16.0
    var color = NoteColor()
    var frame = NoteFrame()
    
    struct NoteColor: Codable {
        var red: Float = Float()
        var green: Float = Float()
        var blue: Float = Float()
        var alpha: Float = Float()
    }
    
    struct NoteFrame: Codable {
        var x: Float = Float()
        var y: Float = Float()
        var width: Float = Float()
        var height: Float = Float()
    }
    
    init(text: String) {
        self.text = text
    }
    
    init(text: String, x: Float, y: Float) {
        self.text = text
        self.frame.x = x
        self.frame.y = y
    }
    
    init(text: String, fontSize: Float, red: Float, green: Float, blue: Float, alpha: Float, width: Float, height: Float, x: Float, y: Float) {
        self.text = text
        self.fontSize = fontSize
        self.color.red = red
        self.color.green = green
        self.color.blue = blue
        self.color.alpha = alpha
        self.frame.width = width
        self.frame.height = height
        self.frame.x = x
        self.frame.y = y
    }
    
}
