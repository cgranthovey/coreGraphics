//
//  ViewController.swift
//  CoreGraphicsPractice
//
//  Created by Christopher Hovey on 11/22/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit
//https://www.raywenderlich.com/90693/modern-core-graphics-with-swift-part-2
class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterView: CounterView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxWaterDrunk: UILabel!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     counterView.isHidden = true
        counterLabel.text = "\(counterView.counter)"
        
        setUpGraphDisplay()
    }

    @IBAction func btnPushButton(sender: PushButtonView){
        if sender.isAddButton{
            counterView.counter = counterView.counter + 1
        } else{
            if counterView.counter > 0{
                counterView.counter = counterView.counter - 1
            }
        }
        counterLabel.text = "\(counterView.counter)"
        if isGraphViewShowing{
            counterViewTap(sender: UITapGestureRecognizer())
        }
    }

    @IBAction func counterViewTap(sender: UITapGestureRecognizer){
        if isGraphViewShowing{
            
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else{
            setUpGraphDisplay()
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing

    }
    
    
    func setUpGraphDisplay(){
        let noOfDays = 7
        
        //replace last date with todays actual date
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        
        //graph needs to be redrawn
        graphView.setNeedsDisplay()
        maxWaterDrunk.text = "\(graphView.graphPoints.max()!)"
        
        print("maximum water drunk: \(graphView.graphPoints.max()!)")
        
        let average = graphView.graphPoints.reduce(0, +)/graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        //get todays day number 
        let calendar = NSCalendar.current
        
        var weekday = calendar.component(.weekday, from: NSDate() as Date)
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        for i in (1...days.count).reversed(){
            if let labelView = graphView.viewWithTag(i) as? UILabel{
                if weekday == 7{
                    weekday = 0
                }
                labelView.text = "\(days[weekday])"
                weekday = weekday - 1
                if weekday < 0 {
                    weekday = days.count - 1
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

