//
//  timerView.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 28/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    @IBOutlet weak var timelabel:UILabel!
    
    var clock:NSTimer!
    var timer = 30 // sec
    
    var decountShape = CAShapeLayer()
    
    var timePassedPercent:Float = 0.0
    
    var completion:(()->Void)!
    
    
    override func awakeFromNib() {
        
        let circlePath = UIBezierPath()
        circlePath.addArcWithCenter(CGPointMake(50, 50), radius: 50, startAngle: 1.5*CGFloat(M_PI), endAngle: 3.5*CGFloat(M_PI), clockwise: true)
        
        decountShape.path = circlePath.CGPath
        decountShape.strokeColor = UIColor.init(colorLiteralRed: 60.0/255.0, green: 148.0/255.0, blue: 209.0/255.0, alpha: 1.0).CGColor
        decountShape.fillColor = UIColor.clearColor().CGColor
        decountShape.lineCap = kCALineCapRound
        decountShape.lineWidth = 5.0
        layer.addSublayer(decountShape)
    }
    
    
    func startTimer(completion:()->Void) {
        
        self.completion = completion
        timelabel.text = "30"
        clock = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TimerView.countdown), userInfo: nil, repeats: true)
    }
    
    func countdown() {
        timer -= 1
        timelabel.text = String(timer)
        
        let oldTimePassedPercent = timePassedPercent
        timePassedPercent += 1.0 / 30.0
        
        let circleStrokeStart = CABasicAnimation(keyPath: "strokeStart")
        circleStrokeStart.duration = 1.0
        circleStrokeStart.fromValue = NSNumber(float: oldTimePassedPercent)
        circleStrokeStart.toValue   = NSNumber(float:timePassedPercent)
        circleStrokeStart.removedOnCompletion = false
        circleStrokeStart.fillMode = kCAFillModeForwards
        decountShape.addAnimation(circleStrokeStart, forKey: "CircleLayerAnimation")
        
        if timer == 0 {
            
            circleStrokeStart.fromValue = NSNumber(float: 1.0)
            circleStrokeStart.toValue = NSNumber(float: 0.0)
            circleStrokeStart.duration = 1.0
            decountShape.addAnimation(circleStrokeStart, forKey: "CircleLayer")
            
            timelabel.text = "30"
            timer = 30
            timePassedPercent = 0.0
            
            completion()
            
            clock.invalidate()
        }
    }
    
}
