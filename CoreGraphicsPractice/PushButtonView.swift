//
//  PushButtonView.swift
//  CoreGraphicsPractice
//
//  Created by Christopher Hovey on 11/22/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit

@IBDesignable
class PushButtonView: UIButton {
 
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        
        var path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        let plusHeight: CGFloat = 3
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        var plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        plusPath.move(to: CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        
        
        if isAddButton{
            plusPath.move(to: CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 - plusWidth/2 + 0.5))
            plusPath.addLine(to: CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))
        }
        UIColor.white.setStroke()
        plusPath.stroke()
    }

}
