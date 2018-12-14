//
//  WallView.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/5.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class WallView: UIView {
    
    var backgroundImageView = UIImageView()
    var coverView = CoverView()
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
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(backgroundImageView)
        addSubview(coverView)
        sendSubviewToBack(backgroundImageView)
        sendSubviewToBack(coverView)
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = bounds
        coverView.frame = bounds
    }
    
    
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
    
    func showCoverView() {
        bringSubviewToFront(coverView)
    }
    
    func hideCoverView() {
        sendSubviewToBack(coverView)
    }
    
    func setBackgroundImage(uiImage: UIImage) {
        backgroundImageView.image = uiImage
    }
    
    
    
    //MARK: 改变所有drag note view字体
    func changeAllDragNoteFont(font: UIFont) {
        for view in subviews {
            if view is DragNoteView {
                let dragNoteView = (view as! DragNoteView)
                dragNoteView.font = font
                dragNoteView.adjustTextLabel()
            }
        }
    }
    
    //MARK: 改变所有drag note view背景
    func changeAllDragNoteBackground(image: UIImage) {
        for view in subviews {
            if view is DragNoteView {
                let dragNoteView = (view as! DragNoteView)
                dragNoteView.noteBackgroundView.image = image
            }
        }
    }
    
    //MARK: 移除所有drag note view
    func removeAllDragNoteView() {
        for view in subviews {
            if view is DragNoteView {
                view.removeFromSuperview()
            }
        }
    }
    

}
