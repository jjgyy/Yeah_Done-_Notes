//
//  RightMenuButton.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class RightMenuButton: UIButton {
    
    var textLabel = UILabel()

    init(text: String) {
        super.init(frame: CGRect.zero)
        textLabel.text = text
        textLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        addSubview(textLabel)
        backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 30.0, y: 0.0, width: bounds.width, height: bounds.height)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 5.0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width-5.0, y: bounds.height))
        context.addPath(path)
        context.setStrokeColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor)
        context.setLineWidth(1)
        context.strokePath()
    }
    
}
