//
//  ChatTextCell.swift
//  Marketmaker
//
//  Created by Big shark on 17/10/2016.
//  Copyright © 2016 Big shark. All rights reserved.
//

import UIKit

@IBDesignable class SenderChatTextCell: UITableViewCell {
    
    
    @IBOutlet weak var imvSenderImage: UIImageView!
    @IBOutlet weak var lblChatContent: UILabel!
    @IBOutlet weak var lblTime: UILabel!

	override func draw(_ rect: CGRect) {

        self.selectionStyle = .none

		let frame = rect
        
        

        let width = rect.width
        let height = rect.height
    
		let bezier2Path = UIBezierPath()
        
        let moveToRight:CGFloat = -5
        //draw start point move to the
		bezier2Path.move(to: CGPoint(x: width - 50 - moveToRight, y: height - 25.01))
		bezier2Path.addLine(to: CGPoint(x: width - 52.93 - moveToRight, y: height - 25))
        
		bezier2Path.addCurve(to: CGPoint(x: width - 52 - moveToRight, y: height - 25.02), controlPoint1: CGPoint(x: width - 52.62, y: height - 25), controlPoint2: CGPoint(x: width - 52.31 - moveToRight, y: height - 25.01))
		bezier2Path.addLine(to: CGPoint(x: width - 52 - moveToRight, y: height - 25.01))
		bezier2Path.close()
		bezier2Path.move(to: CGPoint(x: width - 94.06 - moveToRight, y: frame.minY + 13.02))
		bezier2Path.addCurve(to: CGPoint(x: width - 83.84 - moveToRight, y: frame.minY + 14.31), controlPoint1: CGPoint(x: width - 89.46 - moveToRight, y: frame.minY + 13.09), controlPoint2: CGPoint(x: width - 86.54 - moveToRight, y: frame.minY + 13.35))
		bezier2Path.addLine(to: CGPoint(x: width - 83.13 - moveToRight, y: frame.minY + 14.5))
		bezier2Path.addCurve(to: CGPoint(x: width - 72.83 - moveToRight, y: frame.minY + 25.63), controlPoint1: CGPoint(x: width - 78.34 - moveToRight, y: frame.minY + 16.38), controlPoint2: CGPoint(x: width - 74.57 - moveToRight, y: frame.minY + 20.46))
		bezier2Path.addCurve(to: CGPoint(x: width - 71.44 - moveToRight, y: frame.minY + 43.57), controlPoint1: CGPoint(x: width - 71.44 - moveToRight, y: frame.minY + 30.37), controlPoint2: CGPoint(x: width - 71.44 - moveToRight, y: frame.minY + 34.77))
		bezier2Path.addLine(to: CGPoint(x: width - 71.44 - moveToRight, y: height - 55.57))
		bezier2Path.addCurve(to: CGPoint(x: width - 71.51 - moveToRight, y: height - 47), controlPoint1: CGPoint(x: width - 71.44 - moveToRight, y: height - 52.12), controlPoint2: CGPoint(x: width - 71.44 - moveToRight, y: height - 49.34))
		bezier2Path.addCurve(to: CGPoint(x: width - 71.35 - moveToRight, y: height - 47), controlPoint1: CGPoint(x: width - 71.51 - moveToRight, y: height - 47), controlPoint2: CGPoint(x: width - 71.45 - moveToRight, y: height - 47))
		bezier2Path.addCurve(to: CGPoint(x: width - 71.44 - moveToRight, y: height - 45), controlPoint1: CGPoint(x: width - 71.41 - moveToRight, y: height - 46.34), controlPoint2: CGPoint(x: width - 71.44 - moveToRight, y: height - 45.68))
		bezier2Path.addCurve(to: CGPoint(x: width - 52.93 - moveToRight, y: height - 25), controlPoint1: CGPoint(x: width - 71.44 - moveToRight, y: height - 33.95), controlPoint2: CGPoint(x: width - 63.15 - moveToRight, y: height - 25))
        
        let moveToLeft: CGFloat = 30
            
        
		bezier2Path.addLine(to: CGPoint(x: frame.minX + 102.3 - moveToLeft, y: height - 25))
		bezier2Path.addCurve(to: CGPoint(x: frame.minX + 86.4  - moveToLeft,  y: height - 26.31), controlPoint1: CGPoint(x: frame.minX + 94.15  - moveToLeft, y: height - 25), controlPoint2: CGPoint(x: frame.minX + 90.08 - moveToLeft, y: height - 25))
		bezier2Path.addLine(to: CGPoint(x: frame.minX + 85.69  - moveToLeft, y: height - 26.5))
		bezier2Path.addCurve(to: CGPoint(x: frame.minX + 75.39  - moveToLeft, y: height - 37.63), controlPoint1: CGPoint(x: frame.minX + 80.9 - moveToLeft, y: height - 28.38), controlPoint2: CGPoint(x: frame.minX + 77.13 - moveToLeft, y: height - 32.46))
		bezier2Path.addCurve(to: CGPoint(x: frame.minX + 74 - moveToLeft, y: height - 55.57), controlPoint1: CGPoint(x: frame.minX + 74 - moveToLeft, y: height - 42.37), controlPoint2: CGPoint(x: frame.minX + 74 - moveToLeft, y: height - 46.77))
		bezier2Path.addLine(to: CGPoint(x: frame.minX + 74 - moveToLeft, y: frame.minY + 43.57))
		bezier2Path.addCurve(to: CGPoint(x: frame.minX - moveToLeft + 75.21, y: frame.minY + 26.4), controlPoint1: CGPoint(x: frame.minX - moveToLeft + 74, y: frame.minY + 34.77), controlPoint2: CGPoint(x: frame.minX - moveToLeft + 74, y: frame.minY + 30.37))
		bezier2Path.addLine(to: CGPoint(x: frame.minX + 75.39 - moveToLeft, y: frame.minY + 25.63))
		bezier2Path.addCurve(to: CGPoint(x: frame.minX + 85.69 - moveToLeft, y: frame.minY + 14.5), controlPoint1: CGPoint(x: frame.minX + 77.13 - moveToLeft, y: frame.minY + 20.46), controlPoint2: CGPoint(x: frame.minX + 80.9 - moveToLeft, y: frame.minY + 16.38))
		bezier2Path.addCurve(to: CGPoint(x: frame.minX + 102.3 - moveToLeft, y: frame.minY + 13), controlPoint1: CGPoint(x: frame.minX + 90.08 - moveToLeft, y: frame.minY + 13), controlPoint2: CGPoint(x: frame.minX + 94.15 - moveToLeft, y: frame.minY + 13))
		bezier2Path.addLine(to: CGPoint(x: width - 99.74, y: frame.minY + 13))
		bezier2Path.addCurve(to: CGPoint(x: width - 94.06, y: frame.minY + 13.02), controlPoint1: CGPoint(x: width - 97.58, y: frame.minY + 13), controlPoint2: CGPoint(x: width - 95.71, y: frame.minY + 13))
		bezier2Path.close()

		#colorLiteral(red: 0.003921568627, green: 0.7764705882, blue: 0.7137254902, alpha: 1).setFill()
		bezier2Path.fill()
	}
}

@IBDesignable class ReceiverChatTextCell: UITableViewCell {
    
    @IBOutlet weak var lblChatContent: UILabel!
    @IBOutlet weak var imvReceiverProfile: UIImageView!

    @IBOutlet weak var lblTime: UILabel!

	override func draw(_ rect: CGRect) {

        self.selectionStyle = .none

		let frame = rect

        let width = rect.width
        let height = rect.height
        NSLog("x:\(rect.minX) y:\(rect.minY) width:\(rect.width) height: \(rect.height)")
        
		let bezier2Path = UIBezierPath()
        
        //move to first point
        
		//bezier2Path.move(to: CGPoint(x: width - 280.94, y: frame.minY + 13.02))
        
        let leading : CGFloat = 100
        bezier2Path.move(to: CGPoint(x: leading + 23 - 0.94, y: frame.minY + 13.02))
        //bezier2Path.addCurve(to: CGPoint(x: width - 291.16, y: frame.minY + 14.31), controlPoint1: CGPoint(x: width - 285.54, y: frame.minY + 13.09), controlPoint2: CGPoint(x: width - 288.46, y: frame.minY + 13.35))
        
        bezier2Path.addCurve(to: CGPoint(x: leading + 12 - 0.16, y: frame.minY + 14.31), controlPoint1: CGPoint(x: leading + 18 - 0.54, y: frame.minY + 13.09), controlPoint2: CGPoint(x: leading + 15 - 0.46, y: frame.minY + 13.35))
        
		bezier2Path.addLine(to: CGPoint(x: leading + 12 - 0.87, y: frame.minY + 14.5))
        
		bezier2Path.addCurve(to: CGPoint(x: leading + 1 - 0.17, y: frame.minY + 25.63), controlPoint1: CGPoint(x: leading + 9 - 0.66, y: frame.minY + 16.38), controlPoint2: CGPoint(x: leading + 3 - 0.43, y: frame.minY + 20.46))
        
		bezier2Path.addCurve(to: CGPoint(x: leading - 0.56, y: frame.minY + 43.57), controlPoint1: CGPoint(x: leading - 0.56, y: frame.minY + 30.37), controlPoint2: CGPoint(x: leading - 0.56, y: frame.minY + 34.77))
        
		bezier2Path.addLine(to: CGPoint(x: leading - 0.56, y: height - 55.57))
        
		bezier2Path.addCurve(to: CGPoint(x: leading - 0.49, y: height - 47), controlPoint1: CGPoint(x: leading - 0.56, y: height - 52.12), controlPoint2: CGPoint(x: leading - 0.56, y: height - 49.34))
        
		bezier2Path.addCurve(to: CGPoint(x: leading - 0.65, y: height - 47), controlPoint1: CGPoint(x: leading - 0.49, y: height - 47), controlPoint2: CGPoint(x: leading - 0.55, y: height - 47))
        
		bezier2Path.addCurve(to: CGPoint(x: leading - 0.56, y: height - 45), controlPoint1: CGPoint(x: leading - 0.59, y: height - 46.34), controlPoint2: CGPoint(x: leading - 0.56, y: height - 45.68))
        
        
		bezier2Path.addCurve(to: CGPoint(x: leading - 19 - 0.07, y: height - 25), controlPoint1: CGPoint(x: leading - 0.56, y: height - 33.95), controlPoint2: CGPoint(x: leading - 8 - 0.85, y: height - 25))
        
        let trailing : CGFloat = width - 20
        
        //right corner
		bezier2Path.addLine(to: CGPoint(x: trailing - 29 + 0.7, y: height - 25))
		bezier2Path.addCurve(to: CGPoint(x: trailing - 13 + 0.6, y: height - 26.31), controlPoint1: CGPoint(x: trailing - 21 + 0.85, y: height - 25), controlPoint2: CGPoint(x: trailing - 17 + 0.92, y: height - 25))
        
		bezier2Path.addLine(to: CGPoint(x: trailing - 12 + 0.31, y: height - 26.5))
        
		bezier2Path.addCurve(to: CGPoint(x: trailing - 2 + 0.61, y: height - 37.63), controlPoint1: CGPoint(x: trailing - 7 + 0.1, y: height - 28.38), controlPoint2: CGPoint(x: trailing - 4 + 0.87, y: height - 32.46))
        
		bezier2Path.addCurve(to: CGPoint(x: trailing, y: height - 55.57), controlPoint1: CGPoint(x: trailing, y: height - 42.37), controlPoint2: CGPoint(x: trailing, y: height - 46.77))
        
		bezier2Path.addLine(to: CGPoint(x: trailing, y: frame.minY + 43.57))
        
		bezier2Path.addCurve(to: CGPoint(x: trailing - 2 + 0.79, y: frame.minY + 26.4), controlPoint1: CGPoint(x: trailing, y: frame.minY + 34.77), controlPoint2: CGPoint(x: trailing, y: frame.minY + 30.37))
        
		bezier2Path.addLine(to: CGPoint(x: trailing - 2 + 0.61, y: frame.minY + 25.63))
        
		bezier2Path.addCurve(to: CGPoint(x: trailing - 12 + 0.31, y: frame.minY + 14.5), controlPoint1: CGPoint(x: trailing - 4 + 0.87, y: frame.minY + 20.46), controlPoint2: CGPoint(x: trailing - 7 + 0.1, y: frame.minY + 16.38))
        
		bezier2Path.addCurve(to: CGPoint(x: trailing - 29 + 0.7, y: frame.minY + 13), controlPoint1: CGPoint(x: trailing - 17 + 0.92, y: frame.minY + 13), controlPoint2: CGPoint(x: trailing - 21 + 0.85, y: frame.minY + 13))
        
		bezier2Path.addLine(to: CGPoint(x: leading + 28 - 0.26, y: frame.minY + 13))
        
		bezier2Path.addCurve(to: CGPoint(x: leading + 23 - 0.94, y: frame.minY + 13.02), controlPoint1: CGPoint(x: leading + 26 - 0.42, y: frame.minY + 13), controlPoint2: CGPoint(x: leading + 24 - 0.29, y: frame.minY + 13))
		bezier2Path.close()

		#colorLiteral(red: 0.9346453216, green: 0.9346453216, blue: 0.9346453216, alpha: 1).setFill()
		bezier2Path.fill()
	}
}
