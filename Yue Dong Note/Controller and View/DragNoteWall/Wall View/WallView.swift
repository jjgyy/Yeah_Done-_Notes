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
    var useMenuGuideLabel = UILabel()
    var useEditGuideLabel = UILabel()
    var useAddGuideLabel = UILabel()
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
        configGuideLabel()
        sendSubviewToBack(backgroundImageView)
        sendSubviewToBack(coverView)
        backgroundImageView.contentMode = .scaleAspectFill
        let rightEdgePanGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(rightEdgePanAction(_:)))
        rightEdgePanGes.edges = .right
        addGestureRecognizer(rightEdgePanGes)
    }
    @objc func rightEdgePanAction( _ sender : UIScreenEdgePanGestureRecognizer) {
        if (sender.state == UIScreenEdgePanGestureRecognizer.State.began) {
            controller?.showRightMenuView()
        }
    }
    
    private func configGuideLabel() {
        addSubview(useMenuGuideLabel)
        useMenuGuideLabel.text = NSLocalizedString("use menu guide", comment: "左滑拉出菜单 ←")
        useMenuGuideLabel.font = UIFont.boldSystemFont(ofSize: 14)
        useMenuGuideLabel.isHidden = true
        addSubview(useEditGuideLabel)
        useEditGuideLabel.text = NSLocalizedString("use edit guide", comment: "双击或长按 ↑")
        useEditGuideLabel.font = UIFont.boldSystemFont(ofSize: 14)
        useEditGuideLabel.isHidden = true
        addSubview(useAddGuideLabel)
        useAddGuideLabel.text = NSLocalizedString("use add guide", comment: "点击来新增 ↘")
        useAddGuideLabel.font = UIFont.boldSystemFont(ofSize: 14)
        useAddGuideLabel.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = bounds
        coverView.frame = bounds
        useMenuGuideLabel.frame = CGRect(x: bounds.width - 120, y: center.y, width: 140, height: 30)
        useEditGuideLabel.frame = CGRect(x: bounds.width/2 - 60, y: 380, width: 140, height: 30)
        if let rootCtrl = controller {
            useAddGuideLabel.frame = CGRect(x: rootCtrl.addNewNoteButton.frame.origin.x - 75, y: rootCtrl.addNewNoteButton.frame.origin.y - 20, width: 140, height: 30)
        }
        //useAddGuideLabel.frame = CGRect(x: bounds.width - 160, y: bounds.height - 130, width: 140, height: 30)
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
