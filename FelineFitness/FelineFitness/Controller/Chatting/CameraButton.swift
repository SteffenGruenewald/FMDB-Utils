//
//  CameraButton.swift
//  Marketmaker
//
//  Created by Tiago Mergulhão on 15/11/16.
//  Copyright © 2016 Big shark. All rights reserved.
//

import UIKit


class CameraButton : UIButton {

	override func awakeFromNib() {

		/*let activeImage = buttonImage(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
		setImage(activeImage, for: .highlighted)*/

		let normalImage = buttonImage(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
		setImage(normalImage, for: .normal)
	}

	override func draw(_ rect: CGRect) {

		drawButton(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
	}

	func drawButton (frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25), color : UIColor) {

		let context = UIGraphicsGetCurrentContext()!

		context.saveGState()

		let bezierPath = UIBezierPath()
		bezierPath.move(to: CGPoint(x: 15.67, y: 11))
		bezierPath.addLine(to: CGPoint(x: 10, y: 11))
		bezierPath.addCurve(to: CGPoint(x: 7, y: 13.99), controlPoint1: CGPoint(x: 8.35, y: 11), controlPoint2: CGPoint(x: 7, y: 12.34))
		bezierPath.addLine(to: CGPoint(x: 7, y: 26.01))
		bezierPath.addCurve(to: CGPoint(x: 10, y: 29), controlPoint1: CGPoint(x: 7, y: 27.65), controlPoint2: CGPoint(x: 8.34, y: 29))
		bezierPath.addLine(to: CGPoint(x: 34, y: 29))
		bezierPath.addCurve(to: CGPoint(x: 37, y: 26.01), controlPoint1: CGPoint(x: 35.65, y: 29), controlPoint2: CGPoint(x: 37, y: 27.66))
		bezierPath.addLine(to: CGPoint(x: 37, y: 13.99))
		bezierPath.addCurve(to: CGPoint(x: 34, y: 11), controlPoint1: CGPoint(x: 37, y: 12.35), controlPoint2: CGPoint(x: 35.66, y: 11))
		bezierPath.addLine(to: CGPoint(x: 28.33, y: 11))
		bezierPath.addCurve(to: CGPoint(x: 22, y: 7), controlPoint1: CGPoint(x: 27.2, y: 8.64), controlPoint2: CGPoint(x: 24.79, y: 7))
		bezierPath.addCurve(to: CGPoint(x: 15.67, y: 11), controlPoint1: CGPoint(x: 19.21, y: 7), controlPoint2: CGPoint(x: 16.8, y: 8.64))
		bezierPath.close()
		color.setFill()
		bezierPath.fill()

		let bezier2Path = UIBezierPath()
		bezier2Path.move(to: CGPoint(x: 22, y: 27))
		bezier2Path.addCurve(to: CGPoint(x: 29, y: 20), controlPoint1: CGPoint(x: 25.87, y: 27), controlPoint2: CGPoint(x: 29, y: 23.87))
		bezier2Path.addCurve(to: CGPoint(x: 22, y: 13), controlPoint1: CGPoint(x: 29, y: 16.13), controlPoint2: CGPoint(x: 25.87, y: 13))
		bezier2Path.addCurve(to: CGPoint(x: 15, y: 20), controlPoint1: CGPoint(x: 18.13, y: 13), controlPoint2: CGPoint(x: 15, y: 16.13))
		bezier2Path.addCurve(to: CGPoint(x: 22, y: 27), controlPoint1: CGPoint(x: 15, y: 23.87), controlPoint2: CGPoint(x: 18.13, y: 27))
		bezier2Path.close()
		bezier2Path.move(to: CGPoint(x: 22, y: 25))
		bezier2Path.addCurve(to: CGPoint(x: 17, y: 20), controlPoint1: CGPoint(x: 19.24, y: 25), controlPoint2: CGPoint(x: 17, y: 22.76))
		bezier2Path.addCurve(to: CGPoint(x: 22, y: 15), controlPoint1: CGPoint(x: 17, y: 17.24), controlPoint2: CGPoint(x: 19.24, y: 15))
		bezier2Path.addCurve(to: CGPoint(x: 27, y: 20), controlPoint1: CGPoint(x: 24.76, y: 15), controlPoint2: CGPoint(x: 27, y: 17.24))
		bezier2Path.addCurve(to: CGPoint(x: 22, y: 25), controlPoint1: CGPoint(x: 27, y: 22.76), controlPoint2: CGPoint(x: 24.76, y: 25))
		bezier2Path.close()
		#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
		bezier2Path.fill()

		let ovalPath = UIBezierPath(ovalIn: CGRect(x: 32.5, y: 13.5, width: 2, height: 2))
		#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
		ovalPath.fill()
        context.restoreGState()
	}

	func buttonImage (frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25), color : UIColor) -> UIImage {

		UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 25), false, 0)

		drawButton(color: color)

		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
		
	}
}
