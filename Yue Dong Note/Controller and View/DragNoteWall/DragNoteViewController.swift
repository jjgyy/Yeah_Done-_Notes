//
//  DragNoteViewController.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/4.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit


class DragNoteViewController: UIViewController {
    
    var noteWall = NoteWall()
    var theme = Theme()

    @IBOutlet var rootView: RootView!
        @IBOutlet var wallView: WallView!
            @IBOutlet weak var addNewNoteButton: UIButton!

    
    //MARK: 新增Note
    @IBAction func addNewNote(_ sender: UIButton) {
        addNewNoteButton.isHidden = true
        let newNote = Note(text: "", width: 150, height: 200, x: 150, y: 200)
        let newDragNoteView = DragNoteView(note: newNote, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
        wallView.addSubview(newDragNoteView)
        newDragNoteView.textView.font = UIFont(name: AllFont.allFonts[theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]))
        newDragNoteView.startEditingText()
        noteWall.notes += [newNote]
        saveNoteWall()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTheme()
        rootView.rightMenuView.backgroundConfigurationView.backgroundOptionalTable.indexOfCheckmarkedCell = theme.noteWallBackgroundTableIndex
        rootView.rightMenuView.fontConfigurationView.fontOptionalTable.indexOfCheckmarkedCell = theme.noteFontTableIndex
        rootView.rightMenuView.noteBackgroundConfigurationView.noteBackgroundOptionalTable.indexOfCheckmarkedCell = theme.noteBackgroundTableIndex
        configAddNewNoteButton()
        configWallViewBackgroundImage()
        
        loadNoteWall()
        for note in noteWall.notes {
            let newDragNoteView = DragNoteView(note: note, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
            wallView.addSubview(newDragNoteView)
        }
//        for fontFamilyName in UIFont.familyNames{
//            print("family"+fontFamilyName)
//            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
//                print("font:%@",fontName)
//            }
//            print("---------------")
//        }
    }
    
    //MARK: 配置背景
    func configWallViewBackgroundImage() {
        wallView.backgroundImageView.image = UIImage(named: AllWallBackground.wallBackgrounds[theme.noteWallBackgroundTableIndex].fileName)
//        let decodedData = NSData(base64Encoded:theme.noteWallBackgroundBase64)
//        if decodedData != nil {
//            let decodedimage = UIImage(data: decodedData! as Data)
//            wallView.backgroundImageView.image = decodedimage
//        } else {
//            wallView.backgroundImageView.image = UIImage(named: "sea")
//        }
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
    func setWallBackgroundImageThroughBackgroundOptionalTable(cellIndex: Int) {
        wallView.backgroundImageView.image = UIImage(named: AllWallBackground.wallBackgrounds[cellIndex].fileName)
        theme.noteWallBackgroundTableIndex = cellIndex
//        if let newImageBase64String = image.base64String {
//            theme.noteWallBackgroundBase64 = newImageBase64String
//        } else {
//            print("couldn't change this image to base64 string")
//        }
        saveTheme()
    }
    
    //MARK: 通过字体选择表改变字体
    func setFontThroughBackgroundOptionalTable(cellIndex: Int) {
        if let font = UIFont(name: AllFont.allFonts[cellIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[cellIndex])) {
            wallView.changeAllDragNoteFont(font: font)
            theme.noteFontTableIndex = cellIndex
        }
        saveTheme()
    }
    
    //MARK: 通过便签背景选择表改变便签背景
    func setNoteBackgroundThroughNoteBackgroundOptionalTable(cellIndex: Int) {
        if let image = UIImage(named: AllNoteBackground.allNoteBackgrounds[cellIndex].fileName) {
            wallView.changeAllDragNoteBackground(image: image)
            theme.noteBackgroundTableIndex = cellIndex
        }
        saveTheme()
    }
    
    
    func showRightMenuView() {
        wallView.showCoverView()
        rootView.showRightMenu()
    }
    
    func hideRightMenuView() {
        wallView.hideCoverView()
        rootView.hideRightMenu()
        rootView.rightMenuView.toMain()
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
                    if theme.noteBackgroundTableIndex >= AllWallBackground.wallBackgrounds.count {
                        theme.noteBackgroundTableIndex = 0
                    }
                    if theme.noteFontTableIndex >= AllFont.allFonts.count {
                        theme.noteFontTableIndex = 0
                    }
                    if theme.noteBackgroundTableIndex >= AllNoteBackground.allNoteBackgrounds.count {
                        theme.noteBackgroundTableIndex = 0
                    }
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
