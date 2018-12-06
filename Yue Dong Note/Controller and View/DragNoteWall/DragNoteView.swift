//
//  DragNoteView.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/4.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

class DragNoteView: UIView {

    var textLabel = UILabel()
    var textView = UITextView()
    var noteNail = UIImageView()
    private lazy var originalBounds = bounds
    private var redCorner = UIImageView()
    
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTextLabel()
        addTextView()
        addNoteNail()
        addShadow()
        addLongPressGestureRecognizer()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //添加文字label
    func addTextLabel() {
        textLabel.numberOfLines = 0
        textLabel.frame = CGRect(x: 18.0, y: 32.0, width: 0.0, height: 0.0)
        addSubview(textLabel)
        textLabel.isHidden = false
    }
    
    //添加文字输入区
    func addTextView() {
        textView.frame = textLabel.frame
        textView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        addSubview(textView)
        textView.isHidden = true
    }
    
    //添加大头针图片
    func addNoteNail() {
        noteNail.frame = CGRect(x: 2.0, y: 4.0, width: 36.0, height: 26.0)
        addSubview(noteNail)
    }
    
    
    //添加阴影
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5;
        layer.shadowRadius = 5;
    }
    
    //MARK: 添加长按识别器
    func addLongPressGestureRecognizer() {
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(noteLongPressAction(_:)))
        longPressGes.minimumPressDuration = 1
        longPressGes.numberOfTouchesRequired = 1
        longPressGes.allowableMovement = 15
        addGestureRecognizer(longPressGes)
    }
    @objc func noteLongPressAction( _ sender : UILongPressGestureRecognizer) {
        removeRedCornerFromSuperView()
        startEditingText()
    }
    
    //MARK: 开始编辑text
    func startEditingText() {
        textView.frame = CGRect(x: 13.0, y: 24.0, width: bounds.width - 26.0, height: bounds.height - 40.0)
        textView.attributedText = textLabel.attributedText
        textView.isHidden = false
        textLabel.isHidden = true
        textView.becomeFirstResponder()
    }
    
    //MARK: 结束编辑text
    func endEditingText() {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
            textLabel.attributedText = textView.attributedText
            textView.isHidden = true
            textLabel.isHidden = false
            adjustTextLabel()
        }
    }
    
    //MARK: 根据窗口、文字改变label
    func adjustTextLabel() {
        textLabel.frame.size.width = bounds.width - 36.0
        textLabel.sizeToFit()
        if textLabel.frame.origin.y + textLabel.frame.height >= bounds.height {
            makeNoteBigger()
        }
    }
    
    func makeNoteBigger() {
        UIView.animate(withDuration: 0.1) {
            self.frame.size.width *= 1.1
            self.frame.size.height *= 1.1
        }
        adjustTextLabel()
    }


    //拖动view
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        endEditingText()
        moveFrameWithTouches(touches)
        zoomRedCornerIfMoveIntoIt(touches)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        superview!.bringSubviewToFront(self)
        addRedCornerToSuperView()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        removeRedCornerFromSuperView()
        if !deleteIfGetIntoRubbishRegion(touches) {
            resetFrameIfOutOfScreen()
        }
    }
    
    //添加删除角
    func addRedCornerToSuperView() {
        redCorner.image = UIImage(named: "redCorner")
        redCorner.frame = CGRect(x: 0.0, y: superview!.bounds.height - 160.0, width: 160.0, height: 160.0)
        superview!.addSubview(redCorner)
    }
    
    //移除删除角
    func removeRedCornerFromSuperView() {
        redCorner.removeFromSuperview()
    }
    
    //放大缩小删除角
    func zoomRedCornerIfMoveIntoIt(_ touches: Set<UITouch>) {
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: superview!)
        if nowLocation.x <= 100.0 && nowLocation.y >= superview!.bounds.height - 100.0 {
            UIView.animate(withDuration: 0.1) {
                self.redCorner.frame = CGRect(x: 0.0, y: self.superview!.bounds.height - 190.0, width: 190.0, height: 190.0)
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                self.redCorner.frame = CGRect(x: 0.0, y: self.superview!.bounds.height - 160.0, width: 160.0, height: 160.0)
            }
        }
    }
    
    //frame随手指移动
    func moveFrameWithTouches(_ touches: Set<UITouch>) {
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: self)
        let preLocation = touch.previousLocation(in: self)
        let offsetX = nowLocation.x - preLocation.x
        let offsetY = nowLocation.y - preLocation.y
        var origin = self.frame.origin
        origin.x += offsetX
        origin.y += offsetY
        frame.origin = origin
    }
    
    
    //MARK: 如果超出屏幕，复位
    func resetFrameIfOutOfScreen() {
        var fixedX = frame.origin.x
        var fixedY = frame.origin.y
        if frame.origin.x < -frame.width/2 {
            fixedX = -frame.width/2
        } else if frame.origin.x > superview!.bounds.width - frame.width/2 {
            fixedX = superview!.bounds.width - bounds.width/2
        }
        if frame.origin.y < -frame.height/2 {
            fixedY = -frame.height/2
        } else if frame.origin.y > superview!.bounds.height - frame.height/2 {
            fixedY = superview!.bounds.height - bounds.height/2
        }
        UIView.animate(withDuration: 0.1) {
            self.frame.origin.x = fixedX
            self.frame.origin.y = fixedY
        }
    }
    
    //MARK: 移除便签
    func deleteIfGetIntoRubbishRegion(_ touches: Set<UITouch>) -> Bool {
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: superview)
        if nowLocation.x <= 100.0 && nowLocation.y >= superview!.bounds.height - 100.0 {
            removeFromSuperview()
            return true
        }
        return false
    }
    
    //外框比例放大
    func zoom(with ratio: CGFloat) {
        originalBounds = bounds
        let noteBoundsOffsetX = bounds.width * (ratio - 1.0) / 2.0
        let noteBoundsOffsetY = bounds.height * (ratio - 1.0) / 2.0
        bounds.origin.x -= noteBoundsOffsetX
        bounds.origin.y -= noteBoundsOffsetY
        bounds.size.width *= ratio
        bounds.size.height *= ratio
    }
    func cancelZoom() {
        bounds = originalBounds
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //获取绘图上下文
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        //创建并设置路径
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x:bounds.maxX, y:bounds.maxY))
//        path.addLine(to:CGPoint(x:bounds.minX, y:bounds.minY))
//
//        //添加路径到图形上下文
//        context.addPath(path)
//
//        //设置笔触颜色
//        context.setStrokeColor(UIColor.orange.cgColor)
//        //设置笔触宽度
//        context.setLineWidth(6)
//
//        //绘制路径
//        context.strokePath()
    }
    
    
    
}
