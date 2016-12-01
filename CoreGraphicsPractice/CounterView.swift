//
//  CounterView.swift
//  CoreGraphicsPractice
//
//  Created by Christopher Hovey on 11/22/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π: CGFloat = CGFloat(M_PI)

@IBDesignable
class CounterView: UIView {

    @IBInspectable var counter: Int = 5 {
        didSet{
            if counter <= NoOfGlasses{
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)/2
        let arcWidth: CGFloat = 76
        
        let startAngle: CGFloat = π * 3/4
        let endAngle: CGFloat = π/4
        
        var path = UIBezierPath(arcCenter: center, radius: radius - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat = 2 * π + endAngle - startAngle
        let arcLengthPerGlass: CGFloat = angleDifference / CGFloat(NoOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        let outlinePath = UIBezierPath(arcCenter: center, radius: radius - 2.5, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        outlinePath.addArc(withCenter: center, radius: radius - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        
        outlinePath.close()
        outlineColor.setStroke()
        outlinePath.lineWidth = 5
        outlinePath.stroke()
        
        let context = UIGraphicsGetCurrentContext()
        //1 - save original state
        context?.saveGState()
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5
        let markerSize: CGFloat = 10
        
        //2 - the marker rectangle positioned at the top left
        var markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2, y: 0, width: markerWidth, height: markerSize))
        
        //3 - move top left of context to the previous center position
        context?.translateBy(x: rect.width/2, y: rect.height/2)
        
        for i in 1...NoOfGlasses{
            //4 - save the centred context
            context?.saveGState()
            
            //5 - calculate the rotation angle
            var angle = arcLengthPerGlass * CGFloat(i) + startAngle - π/2
            
            //rotate and translate
            context?.rotate(by: angle)
            context?.translateBy(x: 0, y: rect.height/2 - markerSize)
            //6 - fill the marker rectangle
            markerPath.fill()
            
            //7 - restore the centred context for the next rotate
            context?.restoreGState()
        }
        //8 - restore the original state in case of more painting
        context?.restoreGState()
    }
}
























