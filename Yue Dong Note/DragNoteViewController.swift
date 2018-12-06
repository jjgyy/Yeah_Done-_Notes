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
extension Note.NoteColor {
    var uiColor: UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}

extension DragNoteView {
    func decorateWithNote(with note: Note) -> DragNoteView {
        // TODO: 这边也要重构
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(CGFloat(note.fontSize))
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        self.textLabel.attributedText = NSAttributedString(string: note.text, attributes: [.paragraphStyle:paragraphStyle, .font:font])
        self.textView.attributedText = self.textLabel.attributedText
        self.textView.font = font
        self.backgroundColor = note.color.uiColor
        self.noteFrame = note.frame.uiFrame
        return self
    }
    
}

class DragNoteViewController: UIViewController {
    
    var noteWall = NoteWall()
    @IBOutlet var wallView: UIView!
    @IBOutlet weak var wallBackground: UIImageView!
    @IBOutlet weak var addNewNoteButton: UIButton!
    
    @IBAction func addNewNote(_ sender: UIButton) {
        let newNote = Note(text: "", fontSize: 14.0, red: 1.0, green: 1.0, blue: 0.6, alpha: 1.0, width: 150, height: 200, x: 150, y: 200)
        let newDragNoteView = DragNoteView().decorateWithNote(with: newNote)
        wallView.addSubview(newDragNoteView)
        
        // TODO: 这边重构
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(CGFloat(14.0))
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        newDragNoteView.textView.font = font
        
        newDragNoteView.startEditingText()
        noteWall.notes += [newNote]
        saveNoteWall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wallBackground.image = UIImage(named: "blackboard")
        wallBackground.contentMode = .scaleToFill
        wallView.sendSubviewToBack(wallBackground)
        
        addNewNoteButton.setBackgroundImage(UIImage(named: "addNewNote"), for: UIControl.State.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNoteWall()
        syncDragNoteViews()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        syncNoteWall()
        saveNoteWall()
    }
    
    
    private func dragNoteView2Note(view: DragNoteView) -> Note {
        return Note(text: view.textLabel.attributedText!.string, fontSize: 14.0, red: Float(view.backgroundColor!.cgColor.components![0]), green: Float(view.backgroundColor!.cgColor.components![1]), blue: Float(view.backgroundColor!.cgColor.components![2]), alpha: Float(view.backgroundColor!.cgColor.components![3]), width: Float(view.frame.width), height: Float(view.frame.height), x: Float(view.frame.origin.x), y: Float(view.frame.origin.y))
    }
    
    private func syncDragNoteViews() {
        for note in noteWall.notes {
            let newDragNoteView = DragNoteView().decorateWithNote(with: note)
            wallView.addSubview(newDragNoteView)
        }
    }
    
    private func syncNoteWall() {
        noteWall.notes = []
        for view in wallView.subviews {
            if view is DragNoteView {
                let note = dragNoteView2Note(view: view as! DragNoteView)
                noteWall.notes += [note]
            }
        }
    }
    
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
    }
    
    private func saveNoteWall() {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
