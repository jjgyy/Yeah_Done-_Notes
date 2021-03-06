//
//  DragNoteViewController.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/4.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit
import Social


class DragNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var noteWall = NoteWall()
    var recycleBin = RecycleBin()
    var theme = Theme()
    var creatingNotesNum = 0
    var creatingMemoryNum = 0

    @IBOutlet var rootView: RootView!
        @IBOutlet var wallView: WallView!
            @IBOutlet weak var addNewNoteButton: UIButton!

    
    //MARK: 新增Note
    @IBAction func addNewNote(_ sender: UIButton) {
        wallView.useAddGuideLabel.isHidden = true
        addNewNoteButton.isHidden = true
        
        let newNote = Note(text: "", width: 150, height: 200, x: Float(wallView.center.x) - 75, y: Float(wallView.center.y) - 100)
        noteWall.add(newNote)
        saveNoteToFileSystem(note: newNote)
        
        addCreatingNotesNum()
        
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
        
        checkFirstLaunch()
        
        loadRecycleBin()
        
        loadCreatingNotesNum()
        loadCreatingMemoryNum()
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
        if theme.noteWallBackgroundTableIndex == -1 {
            loadCustomizedBackground()
            return
        }
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
        rootView.reloadEditMemoryView()
        wallView.hideCoverView()
        
        AllWallBackground.reload()
        AllFont.reload()
        AllNoteBackground.reload()
        AllLanguage.reload()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.showRightMenuView()
            self.checkMarkAlltables()
        }
    }
    
    //MARK: 通过回收站创建便签
    func createNoteThroughRecycleBinTable(cellIndex: Int) {
        let newNote = Note(text: recycleBin.deletedNotes[cellIndex].text, width: recycleBin.deletedNotes[cellIndex].frame.width, height: recycleBin.deletedNotes[cellIndex].frame.height, x: Float(10 + 50.arc4random), y: Float(150 + 200.arc4random))
        recycleBin.remove(index: cellIndex)
        saveRecycleBin()
        rootView.rightMenuView.recycleBinView.recycleBinTable.reloadDataAndLayout()
        
        let newDragNoteView = DragNoteView(note: newNote, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
        wallView.addSubview(newDragNoteView)
        wallView.bringSubviewToFront(wallView.coverView)
        newDragNoteView.textView.font = UIFont(name: AllFont.allFonts[theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]))
        
        noteWall.add(newNote)
        saveNoteToFileSystem(note: newNote)
    }
    
    
    func addNewMemoryThroughRightMenu() {
        rootView.editMemoryView.doneButton.isHidden = true
        rootView.editMemoryView.cancelButton.isHidden = true
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.rootView.rightMenuView.frame.origin.x = self.rootView.bounds.width
                self.wallView.hideCoverView()
                self.addNewNoteButton.isHidden = true
        }, completion: {_ in
            self.rootView.editMemoryView.memoryImageView.frame = self.rootView.bounds
            self.rootView.editMemoryView.memoryTextView.frame = CGRect(x: 30, y: self.rootView.bounds.height - 150, width: self.rootView.bounds.width - 60, height: 80)
            let image = self.screenShot()
            self.rootView.showEditMemoryView(image: image, noteWall: self.noteWall)
            self.rootView.editMemoryView.memoryTextView.font = UIFont(name: AllFont.allFonts[self.theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[self.theme.noteFontTableIndex]))
            self.addNewNoteButton.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let isSuccess = self.rootView.editMemoryView.memoryTextView.becomeFirstResponder()
            if !isSuccess {
                print("something error")
            }
        }
    }
    
    
    func watchMemoryThroughRightMenu(fileName: String) {
        let memoryToEdit = getMemory(fileName: fileName)
        rootView.editMemoryView.doneButton.isHidden = true
        rootView.editMemoryView.cancelButton.isHidden = true
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.rootView.rightMenuView.frame.origin.x = self.rootView.bounds.width
                self.wallView.hideCoverView()
        }, completion: {_ in
            self.rootView.editMemoryView.memoryImageView.frame = self.rootView.bounds
            self.rootView.editMemoryView.memoryTextView.frame = CGRect(x: 30, y: self.rootView.bounds.height - 150, width: self.rootView.bounds.width - 60, height: 80)
            self.rootView.showEditMemoryView(memory: memoryToEdit)
            self.rootView.editMemoryView.memoryTextView.font = UIFont(name: AllFont.allFonts[self.theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[self.theme.noteFontTableIndex]))
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.rootView.editMemoryView.exitEditingCondition()
        }
    }
    
    //TODO: 这是为了修复一个系统BUG！
    func reloadMemoryTable() {
        let datas = getMemoryFileList()
        rootView.rightMenuView.memoryView.memoryTable.removeFromSuperview()
        rootView.rightMenuView.memoryView.memoryTable = MemoryTable(memoryTableDatas: datas)
        rootView.rightMenuView.memoryView.addSubview(rootView.rightMenuView.memoryView.memoryTable)
        rootView.rightMenuView.memoryView.setNeedsLayout()
    }
    
    func hideEditMemoryView() {
        rootView.hideEditMemoryView()
    }
    
    
    func shareScreenOnSocialPlatform() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.rootView.rightMenuView.frame.origin.x = self.rootView.bounds.width
                self.wallView.hideCoverView()
                self.addNewNoteButton.isHidden = true
        }, completion: {_ in
            self.rootView.rightMenuView.toMain()
            let image = self.screenShot()
            let items = [image]
            let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)
            //适配IPAD，不然会崩溃
            let popover = shareController.popoverPresentationController
            popover?.sourceView = self.rootView
            popover?.sourceRect = CGRect(x: self.rootView.bounds.width, y: self.rootView.bounds.height/2, width: 0, height: 0)
            popover?.permittedArrowDirections = UIPopoverArrowDirection.right
            
            self.addNewNoteButton.isHidden = false
        })
    }
    
    
    func screenShot() -> UIImage{
        let window = UIApplication.shared.keyWindow!
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    
    func showRightMenuView() {
        wallView.useMenuGuideLabel.isHidden = true
        wallView.showCoverView()
        rootView.showRightMenu()
    }
    
    func hideRightMenuView() {
        wallView.hideCoverView()
        rootView.hideRightMenu()
    }
    
    
    func pickImageForWallBackground() {
        hideRightMenuView()
        let imagePickerCtrl = UIImagePickerController()
        imagePickerCtrl.sourceType = .photoLibrary
        imagePickerCtrl.delegate = self
        present(imagePickerCtrl, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]
        wallView.backgroundImageView.image = image as? UIImage
        rootView.rightMenuView.backgroundConfigurationView.backgroundOptionalTable.indexOfCheckmarkedCell = -1
        rootView.rightMenuView.backgroundConfigurationView.backgroundOptionalTable.markTheCellNeedingMarked()
        theme.noteWallBackgroundTableIndex = -1
        saveTheme()
        dismiss(animated: true, completion: nil)
        if image is UIImage {
            saveCustomizedBackground(image: image as! UIImage)
        }
    }
    
    
    func saveCustomizedBackground(image: UIImage) {
        guard let base64String = image.base64String else {
            print("can't to base64")
            return
        }
        let customizedImage = CustomizedImage(base64String: base64String)
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("CustomizedBackground.json") {
            if let json = customizedImage.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    func loadCustomizedBackground() {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("CustomizedBackground.json") {
            if let jsonData = try? Data(contentsOf: url) {
                if let customizedBackgroundToLoad = CustomizedImage(json: jsonData) {
                    wallView.backgroundImageView.image = customizedBackgroundToLoad.uiImage
                }
            }
        }
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
    func saveMemoryToFileSystem(memory: Memory) {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Memories/" + String(memory.identifier)) {
            if let json = memory.json {
                do {
                    try json.write(to: url)
                } catch let error {
                    print("couldn't save \(error)")
                }
            }
        }
    }
    
    func deleteMemoryFromFileSystem(fileName: String) {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Memories/" + fileName) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("couldn't delete \(error)")
            }
        }
    }
    
    //MARK: 读取回忆列表
    func getMemoryFileList() -> [TableData] {
        var result = [TableData]()
        if let dirUrl = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Memories") {
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
    
    
    func getMemory(fileName: String) -> Memory {
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Memories/" + fileName) {
            if let jsonData = try? Data(contentsOf: url) {
                if let memoryToLoad = Memory(json: jsonData) {
                    return memoryToLoad
                }
            }
        }
        print("Memory File May be Wrong")
        return Memory()
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
    
    
    
    func loadCreatingNotesNum() {
        creatingNotesNum = UserDefaults.standard.integer(forKey: "creatingNotesNum")
    }
    
    func saveCreatingNotesNum() {
        UserDefaults.standard.set(creatingNotesNum, forKey: "creatingNotesNum")
    }
    
    func addCreatingNotesNum() {
        creatingNotesNum += 1
        saveCreatingNotesNum()
    }
    
    func loadCreatingMemoryNum() {
        creatingMemoryNum = UserDefaults.standard.integer(forKey: "creatingMemoryNum")
    }
    
    func saveCreatingMemoryNum() {
        UserDefaults.standard.set(creatingMemoryNum, forKey: "creatingMemoryNum")
    }
    
    func addCreatingMemoryNum() {
        creatingMemoryNum += 1
        saveCreatingMemoryNum()
    }
    
    
    func checkFirstLaunch() {
        if (UserDefaults.standard.bool(forKey: "hasFirstLaunched")) {
            return
        }
        
        let newNote = Note(text: NSLocalizedString("first launch guide note", comment: ""), width: 280, height: 345, x: Float(rootView.bounds.width)/2 - 140, y: 20)
        print(rootView.bounds)
        noteWall.add(newNote)
        saveNoteToFileSystem(note: newNote)
        
        let newDragNoteView = DragNoteView(note: newNote, fontName: AllFont.allFonts[theme.noteFontTableIndex].fileName, fontSize: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]), backgroundName: AllNoteBackground.allNoteBackgrounds[theme.noteBackgroundTableIndex].fileName)
        wallView.addSubview(newDragNoteView)
        newDragNoteView.textView.font = UIFont(name: AllFont.allFonts[theme.noteFontTableIndex].fileName, size: CGFloat(AllFont.allFontsRelativeSize[theme.noteFontTableIndex]))
        
        wallView.useMenuGuideLabel.isHidden = false
        wallView.useEditGuideLabel.isHidden = false
        wallView.useAddGuideLabel.isHidden = false
        
        UserDefaults.standard.set(true, forKey: "hasFirstLaunched")
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
        let pathOfNoteWall = NSHomeDirectory() + "/Documents/Memories"
        if !fileManager.fileExists(atPath: pathOfNoteWall) {
            print("not exist /Memories, try to create it")
            let myDire: String = NSHomeDirectory() + "/Documents/Memories"
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

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

