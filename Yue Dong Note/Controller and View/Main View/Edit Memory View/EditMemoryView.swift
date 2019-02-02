//
//  Edit Memory View.swift
//  Yeah Done!
//
//  Created by Apple on 2018/12/15.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class EditMemoryView: UIView {

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
    var memoryImageView = UIImageView()
    var memoryTextView = EditMemoryTextView()
    var doneButton = UIButton(type: UIButton.ButtonType.system)
    var cancelButton = UIButton(type: UIButton.ButtonType.system)
    
    var memory = Memory()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        addSubview(memoryTextView)
        addSubview(memoryImageView)
        addSubview(doneButton)
        doneButton.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        addSubview(cancelButton)
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        memoryImageView.contentMode = .scaleAspectFill
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func done() {
        memory.intro = memoryTextView.text
        controller?.saveMemoryToFileSystem(memory: memory)
        disappear()
    }
    
    @objc func cancel() {
        disappear()
    }
    
    func disappear() {
        memoryTextView.resignFirstResponder()
        doneButton.isHidden = true
        cancelButton.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.memoryImageView.frame = self.bounds
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.controller?.hideEditMemoryView()
            self.controller?.showRightMenuView()
            self.controller?.reloadMemoryTable()
            self.controller?.rootView.rightMenuView.memoryView.updateCountLabel()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        doneButton.frame = CGRect(x: bounds.width - 80, y: 30, width: 60, height: 30)
        cancelButton.frame = CGRect(x: 20, y: 30, width: 60, height: 30)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        memoryTextView.resignFirstResponder()
        exitEditingCondition()
    }
    
    func enterEditingCondition() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.memoryImageView.frame = CGRect(x: self.bounds.width * 0.3, y: 70, width: self.bounds.width * 0.4, height: self.bounds.height * 0.4)
                        self.memoryTextView.frame = CGRect(x: 30, y: self.memoryImageView.frame.origin.y + self.memoryImageView.frame.height + 20, width: self.bounds.width - 60, height: 80)
        },
                       completion: { _ in
                        self.doneButton.isHidden = false
                        self.cancelButton.isHidden = false
        })
    }
    
    func exitEditingCondition() {
        UIView.animate(withDuration: 0.3, animations: {
            self.memoryImageView.frame = CGRect(x: self.bounds.width * 0.15, y: 70, width: self.bounds.width * 0.7, height: self.bounds.height * 0.7)
            self.memoryTextView.frame = CGRect(x: 30, y: self.memoryImageView.frame.origin.y + self.memoryImageView.frame.height + 20, width: self.bounds.width - 60, height: 80)
        }) { _ in
            self.doneButton.isHidden = false
            self.cancelButton.isHidden = false
        }
            
    }
    
}
