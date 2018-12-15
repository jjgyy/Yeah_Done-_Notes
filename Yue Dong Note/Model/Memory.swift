//
//  Memory.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/15.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation
import UIKit

struct Memory: Codable {
    
    var identifier = Date().timeIntervalSince1970
    var imageBase64 = ""
    var intro = ""
    var noteWall = NoteWall()
    
    init(uiImage: UIImage, intro: String, noteWall: NoteWall) {
        if let imageData = uiImage.pngData() {
            self.imageBase64 = imageData.base64EncodedString()
        }
        self.intro = intro
        self.noteWall = noteWall
    }
    
    init() {
    }
    
    var uiImage: UIImage?{
        get {
            let decodedData = NSData(base64Encoded: imageBase64)
            let decodedimage = UIImage(data: decodedData! as Data)
            return decodedimage
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Memory.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
}
