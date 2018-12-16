//
//  EditingMemoryTextView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/15.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class EditMemoryTextView: UITextView {
    
    var editMemoryView: EditMemoryView? {
        get {
            for view in sequence(first: self, next: { $0?.superview }) {
                if view is EditMemoryView {
                    return view as? EditMemoryView
                }
            }
            return nil
        }
    }

    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        editMemoryView?.enterEditingCondition()
        return true
    }

}
