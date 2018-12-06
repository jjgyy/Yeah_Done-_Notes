//
//  WallView.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/5.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class WallView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for view in subviews {
            if view is DragNoteView {
                if (view as! DragNoteView).textView.isFirstResponder {
                    (view as! DragNoteView).endEditingText()
                }
            }
        }
    }

}
