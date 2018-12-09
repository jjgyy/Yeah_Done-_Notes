//
//  noteBackgroundConfigurationView.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/9.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class NoteBackgroundConfigurationView: RightMenuBranchView {

    var noteBackgroundOptionalLabel = RightMenuLabel(text: NSLocalizedString("Note Style", comment: "便签样式"))
    var noteBackgroundOptionalTable = NoteBackgroundOptionalTable()
    var controller: DragNoteViewController? {
        get {
            for view in sequence(first: self, next: { $0?.superview }) {
                if let responder = view.next {
                    if responder is DragNoteViewController{
                        return responder as? DragNoteViewController
                    }
                }
            }
            return nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noteBackgroundOptionalLabel)
        addSubview(noteBackgroundOptionalTable)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        noteBackgroundOptionalLabel.frame = CGRect(x: 10.0, y: 100.0, width: bounds.width, height: 50.0)
        noteBackgroundOptionalTable.frame = CGRect(x: 0.0, y: 150.0, width: Double(bounds.width), height: Double(noteBackgroundOptionalTable.noteBackgrounds.count) * 44.0)
    }

}
