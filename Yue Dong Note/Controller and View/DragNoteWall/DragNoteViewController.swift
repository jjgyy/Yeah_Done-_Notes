//
//  DragNoteViewController.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/4.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

extension Note.NoteFrame {
    var uiFrame: CGRect {
        return CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
    }
}

extension Theme.NoteColor {
    var uiColor: UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}

extension UIFont {
    func noteFont(fontSize: CGFloat) -> UIFont {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(CGFloat(fontSize))
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        return font
    }
}

extension DragNoteView {
    func decorateWithNote(note: Note, theme: Theme) -> DragNoteView {
        textLabel.attributedText = NSAttributedString(string: note.text, attributes: [.font:UIFont().noteFont(fontSize: CGFloat(theme.noteFontSize))])
        textView.font = UIFont().noteFont(fontSize: CGFloat(theme.noteFontSize))
        textView.attributedText = textLabel.attributedText
        backgroundColor = theme.noteColor.uiColor
        noteNail.image = UIImage(named: theme.noteNailImage)
        frame = note.frame.uiFrame
        adjustTextLabel()
        return self
    }
}

class DragNoteViewController: UIViewController {
    
    var noteWall = NoteWall()
    var theme = Theme(noteColor: Theme.NoteColor(red: 1.0, green: 1.0, blue: 0.6, alpha:1.0), noteFontSize: 14.0, noteWallBackground: "blackboard", noteNailImage: "lightRedNail")
    @IBOutlet var wallView: UIView!
    @IBOutlet weak var wallBackground: UIImageView!
    @IBOutlet weak var addNewNoteButton: UIButton!
    
    //MARK: 新增Note
    @IBAction func addNewNote(_ sender: UIButton) {
        addNewNoteButton.isHidden = true
        let newNote = Note(text: "", width: 150, height: 200, x: 150, y: 200)
        let newDragNoteView = DragNoteView().decorateWithNote(note: newNote, theme: theme)
        wallView.addSubview(newDragNoteView)
        newDragNoteView.textView.font = UIFont().noteFont(fontSize: CGFloat(theme.noteFontSize))
        newDragNoteView.startEditingText()
        noteWall.notes += [newNote]
        saveNoteWall()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTheme()
        addNewNoteButton.setBackgroundImage(UIImage(named: "addNewNote"), for: UIControl.State.normal)
        addLongPressRecognizerToAddNewNoteButton()
        wallBackground.image = UIImage(named: theme.noteWallBackground)
        wallBackground.contentMode = .scaleToFill
        wallView.sendSubviewToBack(wallBackground)
    }
    
    func addLongPressRecognizerToAddNewNoteButton() {
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(noteLongPressAction(_:)))
        longPressGes.minimumPressDuration = 1
        longPressGes.numberOfTouchesRequired = 1
        longPressGes.allowableMovement = 15
        addNewNoteButton.addGestureRecognizer(longPressGes)
    }
    @objc func noteLongPressAction( _ sender : UILongPressGestureRecognizer) {
        if sender.state == UILongPressGestureRecognizer.State.began {
            for i in 0..<AllThemes.themes.count {
                if AllThemes.themes[i].noteWallBackground == theme.noteWallBackground {
                    if i == AllThemes.themes.count - 1 {
                        theme = AllThemes.themes[0]
                        break
                    } else {
                        theme = AllThemes.themes[i + 1]
                        break
                    }
                }
            }
            wallBackground.image = UIImage(named: theme.noteWallBackground)
            removeAllDragNoteView()
            loadNoteWall()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNoteWall()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveTheme()
        saveNoteWall()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        addNewNoteButton.isHidden = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        saveNoteWall()
    }
    
    //MARK: view 转 model
    private func dragNoteView2Note(view: DragNoteView) -> Note {
        return Note(text: view.textLabel.attributedText!.string, width: Float(view.frame.width), height: Float(view.frame.height), x: Float(view.frame.origin.x), y: Float(view.frame.origin.y))
    }
    
    
    //MARK: 读取便签墙
    private func loadNoteWall() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("NoteWall.json") {
            if let jsonData = try? Data(contentsOf: url) {
                if let noteWallToLoad = NoteWall(json: jsonData) {
                    noteWall = noteWallToLoad
                }
            }
        }
        for note in noteWall.notes {
            let newDragNoteView = DragNoteView().decorateWithNote(note: note, theme: theme)
            wallView.addSubview(newDragNoteView)
        }
    }
    
    //MARK: 存储便签墙
    func saveNoteWall() {
        noteWall.notes = []
        for view in wallView.subviews {
            if view is DragNoteView {
                let note = dragNoteView2Note(view: view as! DragNoteView)
                noteWall.notes += [note]
            }
        }
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("NoteWall.json") {
            if let json = noteWall.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    //MARK: 读取主题
    private func loadTheme() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Theme.json") {
            if let jsonData = try? Data(contentsOf: url) {
                if let themeToLoad = Theme(json: jsonData) {
                    theme = themeToLoad
                }
            }
        }
    }
    
    //MARK: 存储主题
    func saveTheme() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Theme.json") {
            if let json = theme.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    //MARK: 移除所有drag note view
    func removeAllDragNoteView() {
        for view in wallView.subviews {
            if view is DragNoteView {
                view.removeFromSuperview()
            }
        }
    }
    

}

