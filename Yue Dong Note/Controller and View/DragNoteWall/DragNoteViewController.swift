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
        var font = UIFont(name: "AaTaoTaoti", size: 17.0)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font!)
        return font!
    }
}

extension DragNoteView {
    func decorateWithNote(note: Note, theme: Theme) -> DragNoteView {
        textLabel.attributedText = NSAttributedString(string: note.text, attributes: [.font:UIFont().noteFont(fontSize: CGFloat(theme.noteFontSize))])
        textView.font = UIFont().noteFont(fontSize: CGFloat(theme.noteFontSize))
        textView.attributedText = textLabel.attributedText
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        noteNail.image = UIImage(named: theme.noteNailImage)
        noteBackgroundView.image = UIImage(named: "note2")
        frame = note.frame.uiFrame
        adjustNoteBackgroundView()
        adjustTextLabel()
        return self
    }
}

extension CoverView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        superview!.sendSubviewToBack(self)
        for view in superview!.subviews {
            if view is RightMenuView {
                let rightMenuView = view as! RightMenuView
                UIView.animate(withDuration: 0.2) {
                    rightMenuView.frame.origin.x = self.superview!.bounds.width
                }
            }
        }
    }
}

extension BackgroundOptionalTable {
    
    var controller: DragNoteViewController? {
        get {
            for view in sequence(first: self.superview, next: { $0?.superview }) {
                if let responder = view?.next {
                    if responder is DragNoteViewController{
                        return responder as? DragNoteViewController
                    }
                }
            }
            return nil
        }
    }
    
    func markTheCellNeedingMarked() {
        if indexPathsForVisibleRows != nil {
            for indexPath in indexPathsForVisibleRows! {
                if indexPath.row == indexOfCheckmarkedCell {
                    cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                } else {
                    cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfCheckmarkedCell = indexPath.row
        markTheCellNeedingMarked()
        let imageName = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        if let image = UIImage(named: imageName) {
            controller!.setWallBackgroundImageThroughBackgroundOptionalTable(image: image, cellIndex: indexPath.row)
        }
    }
    
    
}


class DragNoteViewController: UIViewController {
    
    var noteWall = NoteWall()
    var theme = Theme(noteColor: Theme.NoteColor(red: 1.0, green: 1.0, blue: 0.6, alpha:1.0), noteFontSize: 14.0, noteWallBackgroundBase64: "blackboard", noteNailImage: "lightRedNail")
    
    var coverView = CoverView()
    var rightMenuView = RightMenuView()
    var backgroundOptionalTableView = BackgroundOptionalTable(frame: CGRect.zero, style: UITableView.Style.plain, source: AllWallBackground.wallBackgrounds)
    @IBOutlet var wallView: WallView!
    @IBOutlet weak var wallBackgroundView: UIImageView!
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
        configAddNewNoteButton()
        configWallBackgroundView()
        configRightMenuView()
        configCoverView()
        configRightEdgePanGesture()
//        for fontFamilyName in UIFont.familyNames{
//            print("family"+fontFamilyName)
//            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
//                print("font:%@",fontName)
//            }
//            print("---------------")
//        }
    }
    
    //MARK: 配置右边缘左滑
    func configRightEdgePanGesture() {
        let rightEdgePanGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(rightEdgePanAction(_:)))
        rightEdgePanGes.edges = .right
        wallView.addGestureRecognizer(rightEdgePanGes)
    }
    @objc func rightEdgePanAction( _ sender : UIScreenEdgePanGestureRecognizer) {
        if (sender.state == UIScreenEdgePanGestureRecognizer.State.began) {
            showRightMenuView()
        }
    }

    //MARK: 配置背景
    func configWallBackgroundView() {
        let decodedData = NSData(base64Encoded:theme.noteWallBackgroundBase64)
        if decodedData != nil {
            let decodedimage = UIImage(data: decodedData! as Data)
            wallBackgroundView.image = decodedimage
        } else {
            wallBackgroundView.image = UIImage(named: "sea")
        }
        wallBackgroundView.contentMode = .scaleToFill
        wallView.backgroundImageView = wallBackgroundView
        wallView.sendSubviewToBack(wallBackgroundView)
    }
    
    //MARK: 配置右侧菜单
    func configRightMenuView() {
        wallView.addSubview(rightMenuView)
        rightMenuView.frame = CGRect(x: wallView.bounds.width, y: 0, width: 240.0, height: wallView.bounds.height)
        let backgroundOptionLabel = UILabel(frame: CGRect(x: 10.0, y: 50.0, width: 100.0, height: 50.0))
        backgroundOptionLabel.text = "背景"
        rightMenuView.addSubview(backgroundOptionLabel)
        configBackgroundOptionalTableView()
        let swipeTheMenuGesRec = UISwipeGestureRecognizer(target: self, action: #selector(swipTheMenuGesAction(_:)))
        swipeTheMenuGesRec.direction = .right
        rightMenuView.addGestureRecognizer(swipeTheMenuGesRec)
    }
    @objc func swipTheMenuGesAction( _ sender : UISwipeGestureRecognizer) {
        hideRightMenuView()
    }
    
    //MARK: 配置背景选择表
    func configBackgroundOptionalTableView() {
        rightMenuView.addSubview(backgroundOptionalTableView)
        backgroundOptionalTableView.frame = CGRect(x: 0.0, y: 100.0, width: rightMenuView.bounds.width, height: 240.0)
        backgroundOptionalTableView.backgroundColor = rightMenuView.backgroundColor
        backgroundOptionalTableView.indexOfCheckmarkedCell = theme.noteWallBackgroundTableIndex
    }
    
    //MARK: 配置遮罩层
    func configCoverView() {
        wallView.addSubview(coverView)
        coverView.frame = wallView.frame
        wallView.sendSubviewToBack(coverView)
    }
    
    //MARK: 配置新便签按钮
    func configAddNewNoteButton() {
        addNewNoteButton.setBackgroundImage(UIImage(named: "addNewNote"), for: UIControl.State.normal)
        addLongPressRecognizerToAddNewNoteButton()
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
            showRightMenuView()
        }
    }
    
    //MARK: 通过背景选择表改变背景
    func setWallBackgroundImageThroughBackgroundOptionalTable(image: UIImage, cellIndex: Int) {
        wallView.backgroundImageView.image = image
        theme.noteWallBackgroundTableIndex = cellIndex
        if let newImageBase64String = image.base64String {
            theme.noteWallBackgroundBase64 = newImageBase64String
        } else {
            print("couldn't change this image to base64 string")
        }
    }
    
    
    func showRightMenuView() {
        wallView.bringSubviewToFront(coverView)
        wallView.bringSubviewToFront(rightMenuView)
        UIView.animate(withDuration: 0.2) {
            self.rightMenuView.frame.origin.x = self.wallView.bounds.width - self.rightMenuView.frame.width
        }
        backgroundOptionalTableView.markTheCellNeedingMarked()
    }
    
    func hideRightMenuView() {
        wallView.sendSubviewToBack(coverView)
        UIView.animate(withDuration: 0.2) {
            self.rightMenuView.frame.origin.x = self.wallView.bounds.width
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNoteWall()
        rightMenuView.frame.origin.x = wallView.bounds.width
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
    
    
    //MARK: view 转 model
    private func dragNoteView2Note(view: DragNoteView) -> Note {
        return Note(text: view.textLabel.attributedText!.string, width: Float(view.frame.width), height: Float(view.frame.height), x: Float(view.frame.origin.x), y: Float(view.frame.origin.y))
    }
    
    

}


extension UIImage {
    var base64String: String? {
        let imageData = self.pngData()
        return imageData?.base64EncodedString()
    }
}

extension String {
    var uiImage: UIImage? {
        let decodedData = NSData(base64Encoded: self)
        let decodedimage = UIImage(data: decodedData! as Data)
        return decodedimage
    }
}
