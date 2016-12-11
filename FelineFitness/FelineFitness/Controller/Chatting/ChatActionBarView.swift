//
//  MmChatActionBarView.swift
//  Marketmaker
//
//  Created by Big shark on 17/10/2016.
//  Copyright © 2016 Big shark. All rights reserved.
//

import UIKit

let kChatActionBarOriginalHeight: CGFloat = 78      //ActionBar orginal height
let kChatActionBarTextViewMaxHeight: CGFloat = 51   //Expandable textview max

//Chat Action Bar Delegate
@objc protocol ChatActionBarViewDelegate: class {
    
    func chatActionBarSendChat()
    
    func chatActionBarSendPhoto()
}



@IBDesignable class ChatActionBarView: UIView {
    
    weak var delegate : ChatActionBarViewDelegate?
    
    var inputTextViewCurrentHeight: CGFloat = kChatActionBarOriginalHeight

    @IBOutlet weak var inputTextView: UITextView!{ didSet{
        inputTextView.font = UIFont.systemFont(ofSize: 15)
        inputTextView.scrollsToTop = false
        inputTextView.textContainerInset = UIEdgeInsetsMake(7, 5, 5, 5)
        inputTextView.enablesReturnKeyAutomatically = true
        inputTextView.layoutManager.allowsNonContiguousLayout = false
        inputTextView.scrollsToTop = false
        }
    }

    /*
	func drawChatBox (textBox: CGRect = CGRect(x: 0, y: 53, width: 375, height: 78)) {

		let path = UIBezierPath()
        
        
        //move to start point
		path.move(to: CGPoint(x: textBox.maxX - 76.35, y: textBox.minY + 15.33))
		path.addLine(to: CGPoint(x: textBox.maxX - 76.16, y: textBox.minY + 15.37))
        
        //add right corner radius
		path.addCurve(to: CGPoint(x: textBox.maxX - 73.37, y: textBox.minY + 18.16), controlPoint1: CGPoint(x: textBox.maxX - 74.86, y: textBox.minY + 15.85), controlPoint2: CGPoint(x: textBox.maxX - 73.85, y: textBox.minY + 16.86))
        
        
		path.addCurve(to: CGPoint(x: textBox.maxX - 73, y: textBox.minY + 22.64), controlPoint1: CGPoint(x: textBox.maxX - 73, y: textBox.minY + 19.34), controlPoint2: CGPoint(x: textBox.maxX - 73, y: textBox.minY + 20.44))
        
        
		path.addCurve(to: CGPoint(x: textBox.maxX - 73, y: textBox.maxY - 24.5), controlPoint1: CGPoint(x: textBox.maxX - 73, y: textBox.minY + 22.64), controlPoint2: CGPoint(x: textBox.maxX - 73, y: textBox.maxY - 51.7))
        
        
		path.addCurve(to: CGPoint(x: textBox.maxX - 67, y: textBox.maxY - 14), controlPoint1: CGPoint(x: textBox.maxX - 70.63, y: textBox.maxY - 20.35), controlPoint2: CGPoint(x: textBox.maxX - 67, y: textBox.maxY - 14))
        
		path.addLine(to: CGPoint(x: textBox.minX + 21.64, y: textBox.maxY - 14))
        
		path.addCurve(to: CGPoint(x: textBox.minX + 17.35, y: textBox.maxY - 14.33), controlPoint1: CGPoint(x: textBox.minX + 19.44, y: textBox.maxY - 14), controlPoint2: CGPoint(x: textBox.minX + 18.34, y: textBox.maxY - 14))
        
		path.addLine(to: CGPoint(x: textBox.minX + 17.16, y: textBox.maxY - 14.37))
        
		path.addCurve(to: CGPoint(x: textBox.minX + 14.37, y: textBox.maxY - 17.16), controlPoint1: CGPoint(x: textBox.minX + 15.86, y: textBox.maxY - 14.85), controlPoint2: CGPoint(x: textBox.minX + 14.85, y: textBox.maxY - 15.86))
        
		path.addCurve(to: CGPoint(x: textBox.minX + 14, y: textBox.maxY - 21.64), controlPoint1: CGPoint(x: textBox.minX + 14, y: textBox.maxY - 18.34), controlPoint2: CGPoint(x: textBox.minX + 14, y: textBox.maxY - 19.44))
        
		path.addLine(to: CGPoint(x: textBox.minX + 14, y: textBox.minY + 22.64))
        
		path.addCurve(to: CGPoint(x: textBox.minX + 14.33, y: textBox.minY + 18.35), controlPoint1: CGPoint(x: textBox.minX + 14, y: textBox.minY + 20.44), controlPoint2: CGPoint(x: textBox.minX + 14, y: textBox.minY + 19.34))
        
		path.addLine(to: CGPoint(x: textBox.minX + 14.37, y: textBox.minY + 18.16))
        
		path.addCurve(to: CGPoint(x: textBox.minX + 17.16, y: textBox.minY + 15.37), controlPoint1: CGPoint(x: textBox.minX + 14.85, y: textBox.minY + 16.86), controlPoint2: CGPoint(x: textBox.minX + 15.86, y: textBox.minY + 15.85))
		path.addCurve(to: CGPoint(x: textBox.minX + 21.64, y: textBox.minY + 15), controlPoint1: CGPoint(x: textBox.minX + 18.34, y: textBox.minY + 15), controlPoint2: CGPoint(x: textBox.minX + 19.44, y: textBox.minY + 15))
		path.addLine(to: CGPoint(x: textBox.maxX - 80.64, y: textBox.minY + 15))
        
		path.addCurve(to: CGPoint(x: textBox.maxX - 76.35, y: textBox.minY + 15.33), controlPoint1: CGPoint(x: textBox.maxX - 78.44, y: textBox.minY + 15), controlPoint2: CGPoint(x: textBox.maxX - 77.34, y: textBox.minY + 15))
        
		path.close()

		UIColor.white.setFill()

		path.fill()

		UIColor.lightGray.setStroke()

		path.lineWidth = 1
		path.stroke()
	}

 */
	override func draw(_ rect: CGRect) {
		//drawChatBox(textBox: rect)
	}


    override init (frame: CGRect) {
        super.init(frame : frame)
    }

    convenience init () {
        self.init(frame:CGRect.zero)
    }

	override func prepareForInterfaceBuilder() {}

    override func awakeFromNib() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
    
    

}

extension ChatActionBarView {
    
    @IBAction func sendButtonTapped(_ sender: AnyObject) {
        
        delegate?.chatActionBarSendChat()
    }
    
    
    @IBAction func SendPhotoButtonTapped(_ sender: Any) {

		delegate?.chatActionBarSendPhoto()
    }
    
    
    func inputTextViewCallKeyboard() {
        self.inputTextView.isHidden = false
        
    }
    
    func resignKeyboard() {
        self.inputTextView.resignFirstResponder()
        
    }
    
    
}
