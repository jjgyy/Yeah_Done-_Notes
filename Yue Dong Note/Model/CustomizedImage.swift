//
//  CustomizedImage.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/16.
//  Copyright © 2018 Young. All rights reserved.
//

import Foundation
import UIKit

struct CustomizedImage: Codable {
    
    var base64String = ""
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(base64String: String) {
        self.base64String = base64String
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(CustomizedImage.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    var uiImage: UIImage?{
        get {
            let decodedData = NSData(base64Encoded: base64String)
            let decodedimage = UIImage(data: decodedData! as Data)
            return decodedimage
        }
    }
}
