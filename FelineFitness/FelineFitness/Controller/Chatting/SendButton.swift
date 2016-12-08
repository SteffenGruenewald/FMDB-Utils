//
//  SendButton.swift
//  Marketmaker
//
//  Created by Tiago Mergulhão on 15/11/16.
//  Copyright © 2016 Big shark. All rights reserved.
//

import UIKit

class SendButton : UIButton {

	override func awakeFromNib() {

		/*let activeImage = buttonImage(color: #colorLiteral(red: 0.003921568627, green: 0.7764705882, blue: 0.7137254902, alpha: 1), planeColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
		setImage(activeImage, for: .highlighted)*/

		let normalImage = buttonImage(color: #colorLiteral(red: 0.002525252525, green: 0.5, blue: 0.458543771, alpha: 1), planeColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
		setImage(normalImage, for: .normal)
	}

	override func draw(_ rect: CGRect) {

		drawButton(color: #colorLiteral(red: 0.003921568627, green: 0.7764705882, blue: 0.7137254902, alpha: 1), planeColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
	}

	func drawButton (frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25), color : UIColor, planeColor : UIColor) {

		let context = UIGraphicsGetCurrentContext()!

		context.saveGState()

		let oval = UIBezierPath(ovalIn: CGRect(x: 0, y: -0, width: 50, height: 50))

		color.setFill()
		oval.fill()

		let path = UIBezierPath()
		path.move(to: CGPoint(x: 16.01, y: 14))
		path.addLine(to: CGPoint(x: 38, y: 25))
		path.addLine(to: CGPoint(x: 16.01, y: 36))
		path.addLine(to: CGPoint(x: 16, y: 27.44))
		path.addLine(to: CGPoint(x: 31.71, y: 25))
		path.addLine(to: CGPoint(x: 16, y: 22.56))
		path.addLine(to: CGPoint(x: 16.01, y: 14))
		path.close()

		planeColor.setFill()
		path.fill()

		context.restoreGState()
	}

	func buttonImage (frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25), color : UIColor, planeColor : UIColor) -> UIImage {

		UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 25), false, 0)

		drawButton(color: color, planeColor: planeColor)

		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()

		return image

	}
}
