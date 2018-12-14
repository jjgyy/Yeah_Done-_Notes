//
//  DragNoteViewController.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/4.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit
import Social


class DragNoteViewController: UIViewController {
    
    var noteWall = NoteWall()
    var recycleBin = RecycleBin()
    var theme = Theme()

    @IBOutlet var rootView: RootView!
        @IBOutlet var wallView: WallView!
            @IBOutlet weak var addNewNoteButton: UIButton!

    
    //MARK: 新增Note
    @IBAction func addNewNote(_ sender: UIButton) {
        addNewNoteButton.isHidden = true
        
        let newNote = Note(text: "", width: 150, height: 200, x: Float(wallView.center.x) - 75, y: Float(wallView.center.y) - 100)
        noteWall.add(newNote)
        saveNoteToFileSystem(note: newNote)
        
        let newDragNoteView = DragNoteView(note: newNote, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
        wallView.addSubview(newDragNoteView)
        newDragNoteView.textView.font = UIFont(name: AllFont.allFonts[theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]))
        newDragNoteView.startEditingText()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        addNewNoteButton.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkFileSystem()
        
        configAddNewNoteButton()
        
        loadTheme()
        checkMarkAlltables()
        configWallViewBackgroundImage()
        
        loadAllNotes()
        for note in noteWall.notes {
            let newDragNoteView = DragNoteView(note: note, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
            wallView.addSubview(newDragNoteView)
        }
        
        loadRecycleBin()
//        for fontFamilyName in UIFont.familyNames{
//            print("family"+fontFamilyName)
//            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
//                print("font:%@",fontName)
//            }
//            print("---------------")
//        }
    }
    
    func checkMarkAlltables() {
        rootView.rightMenuView.backgroundConfigurationView.backgroundOptionalTable.indexOfCheckmarkedCell = theme.noteWallBackgroundTableIndex
        rootView.rightMenuView.fontConfigurationView.fontOptionalTable.indexOfCheckmarkedCell = theme.noteFontTableIndex
        rootView.rightMenuView.noteBackgroundConfigurationView.noteBackgroundOptionalTable.indexOfCheckmarkedCell = theme.noteBackgroundTableIndex
        rootView.rightMenuView.languageConfigurationView.languageOptionalTable.indexOfCheckmarkedCell = UserDefaults.standard.integer(forKey: "userLanguageTableIndex")
    }
    
    
    //MARK: 配置背景
    func configWallViewBackgroundImage() {
        wallView.backgroundImageView.image = UIImage(named: AllWallBackground.allWallBackgrounds[theme.noteWallBackgroundTableIndex].fileName)
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
        wallView.backgroundImageView.image = UIImage(named: AllWallBackground.allWallBackgrounds[cellIndex].fileName)
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
    
    //MARK: 通过语言选择表改变语言
    func setLanguageThroughLanguageOptionalTable(cellIndex: Int) {
        UserDefaults.standard.set(String(cellIndex), forKey: "userLanguageTableIndex")
        rootView.reloadRightMenu()
        wallView.hideCoverView()
        
        AllWallBackground.reload()
        AllFont.reload()
        AllNoteBackground.reload()
        AllLanguage.reload()
        //TODO: reload Social Platform
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.showRightMenuView()
            self.checkMarkAlltables()
        }
    }
    
    //MARK: 通过回收站创建便签
    func createNoteThroughRecycleBinTable(cellIndex: Int) {
        let newNote = Note(text: recycleBin.deletedNotes[cellIndex].text, width: recycleBin.deletedNotes[cellIndex].frame.width, height: recycleBin.deletedNotes[cellIndex].frame.height, x: 50, y: 200)
        
        let newDragNoteView = DragNoteView(note: newNote, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
        wallView.addSubview(newDragNoteView)
        wallView.bringSubviewToFront(wallView.coverView)
        newDragNoteView.textView.font = UIFont(name: AllFont.allFonts[theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]))
        
        noteWall.add(newNote)
        saveNoteToFileSystem(note: newNote)
    }
    
    func shareScreenOnSocialPlatform() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.rootView.rightMenuView.frame.origin.x = self.rootView.bounds.width
                self.wallView.hideCoverView()
        }, completion: {_ in
            self.rootView.rightMenuView.toMain()
            let image = self.screenShot()
            let items = [image]
            let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)
        })
    }
    
    private func screenShot() -> UIImage{
        let window = UIApplication.shared.keyWindow!
        UIGraphicsBeginImageContext(window.bounds.size)
        // 绘图
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        // 从图形上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    
    func showRightMenuView() {
        wallView.showCoverView()
        rootView.showRightMenu()
    }
    
    func hideRightMenuView() {
        wallView.hideCoverView()
        rootView.hideRightMenu()
    }
    
    
    
    //MARK: 读取便签墙
    private func loadAllNotes() {
        if let dirUrl = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Notes") {
            if let contentsOfPath = try? FileManager.default.contentsOfDirectory(atPath: dirUrl.path) {
                for content in contentsOfPath {
                    if let url = try? FileManager.default.url(
                        for: .documentDirectory,
                        in: .userDomainMask,
                        appropriateFor: nil,
                        create: true
                        ).appendingPathComponent("Notes/" + content) {
                        if let jsonData = try? Data(contentsOf: url) {
                            if let noteToLoad = Note(json: jsonData) {
                                noteWall.add(noteToLoad)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: 存储Note单文件
    func saveNoteToFileSystem(note: Note) {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Notes/" + String(note.identifier) + ".json") {
            if let json = note.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    //MARK: 删除Note单文件
    func deleteNoteFromFileSystem(note: Note) {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Notes/" + String(note.identifier) + ".json") {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("couldn't delete \(error)")
            }
        }
    }
    
    //MARK: 读取回收站
    private func loadRecycleBin() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("RecycleBin.json") {
            if let jsonData = try? Data(contentsOf: url) {
                if let recycleBinToLoad = RecycleBin(json: jsonData) {
                    recycleBin = recycleBinToLoad
                }
            }
        }
    }
    
    //MARK: 存储回收站
    func saveRecycleBin() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("RecycleBin.json") {
            if let json = recycleBin.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    //MARK: 存储回忆墙
    func saveNoteWall() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("NoteWalls/" + String(Date().timeIntervalSince1970)) {
            if let json = noteWall.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    func deleteNoteWall(fileName: String) {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("NoteWalls/" + fileName) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("couldn't delete \(error)")
            }
        }
    }
    
    //MARK: 读取回忆墙列表
    func getNoteWallFileList() -> [TableData] {
        var result = [TableData]()
        if let dirUrl = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("NoteWalls") {
            if let contentsOfPath = try? FileManager.default.contentsOfDirectory(atPath: dirUrl.path) {
                for content in contentsOfPath {
                    guard let timeInterval = TimeInterval(content) else {
                        continue
                    }
                    let dateFormatter = DateFormatter()
                    //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.dateFormat = "yyyy - MM.dd -"
                    let date = Date(timeIntervalSince1970: timeInterval)
                    result.append(TableData(uiName: dateFormatter.string(from: date) + " " + NSLocalizedString("'s Momery", comment: "的回忆"), fileName: content))
                }
            }
        }
        return result
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
                    if theme.noteWallBackgroundTableIndex >= AllWallBackground.allWallBackgrounds.count {
                        theme.noteWallBackgroundTableIndex = 0
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
    
    
    func checkFileSystem() {
        let fileManager = FileManager.default
        let pathOfNotes = NSHomeDirectory() + "/Documents/Notes"
        if !fileManager.fileExists(atPath: pathOfNotes) {
            print("not exist /Notes, try to create it")
            let myDire: String = NSHomeDirectory() + "/Documents/Notes"
            let fileManager = FileManager.default
            try! fileManager.createDirectory(atPath: myDire, withIntermediateDirectories: true, attributes: nil)
        }
        let pathOfNoteWall = NSHomeDirectory() + "/Documents/NoteWalls"
        if !fileManager.fileExists(atPath: pathOfNoteWall) {
            print("not exist /NoteWalls, try to create it")
            let myDire: String = NSHomeDirectory() + "/Documents/NoteWalls"
            let fileManager = FileManager.default
            try! fileManager.createDirectory(atPath: myDire, withIntermediateDirectories: true, attributes: nil)
        }
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
