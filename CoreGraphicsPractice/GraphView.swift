//
//  GraphView.swift
//  CoreGraphicsPractice
//
//  Created by Christopher Hovey on 11/30/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.orange
    @IBInspectable var endColor: UIColor = UIColor.blue
    
    var graphPoints = [5, 6, 8, 2, 4, 3, 4]
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        layer.cornerRadius = 8
        clipsToBounds = true

        //2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 - set up the color stops
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorLocations: [CGFloat] = [0.0, 1.0]
        //5 - create the gradient
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)

        //6 - draw the gradient
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        
        context!.drawLinearGradient(gradient!,
                                    start: startPoint,
                                    end: endPoint,
                                    options: CGGradientDrawingOptions(rawValue: 0))

        
        //calculate the x point
        let margin: CGFloat = 20.0
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x: CGFloat = CGFloat(column) * spacer
            x = x + margin + 2
            return x
        }
        
        //calc y point
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight: CGFloat = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        //draw line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
       
        
        for i in 1..<graphPoints.count{
            print("Called")
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        //create clipping path for graph gradient
        //save the state of the context
        
        context?.saveGState()
        
        
        //make copy of path
        var clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        context?.restoreGState()
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        //draw circle on top of the graph strokes
        
        for i in 0..<graphPoints.count{
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x = point.x - 2.5
            point.y = point.y - 2.5
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
            
        }
        
        //draw horizontal lines on top of eveything
        let linePath = UIBezierPath()
        
        //top line
        linePath.move(to: CGPoint(x: margin, y: highestYPoint))
        linePath.addLine(to: CGPoint(x: width - margin, y: highestYPoint))
        
        var middleGraphPoint = graphHeight/2 + topBorder
        linePath.move(to: CGPoint(x: margin, y: middleGraphPoint))
        linePath.addLine(to: CGPoint(x: width - margin, y: middleGraphPoint))
        
        linePath.move(to: CGPoint(x: margin, y: bounds.height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        
        let lineColor = UIColor.init(white: 255, alpha: 0.3)
        
        lineColor.setStroke()
        
        linePath.lineWidth = 2
        linePath.stroke()
        
    }
}















