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
        backgroundImageView.contentMode = .scaleToFill
        coverView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = frame
        coverView.frame = frame
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
    
    //MARK: 移除所有drag note view
    func removeAllDragNoteView() {
        for view in subviews {
            if view is DragNoteView {
                view.removeFromSuperview()
            }
        }
    }
    

}
