//
//  CheckmarkView.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 28/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit

class Checkmark: UIView {
    
    @IBInspectable var colorCheckmark:UIColor = UIColor.greenColor() {
        didSet {
            checkMarkLayer.strokeColor = colorCheckmark.CGColor
            circleLayer.strokeColor = colorCheckmark.CGColor
            grayCircleLayer.strokeColor = colorCheckmark.CGColor
        }
    }
    
    @IBInspectable var colorCross:UIColor = UIColor.redColor() {
        didSet {
            crossLeftLayer.strokeColor = colorCross.CGColor
            crossRightLayer.strokeColor = colorCross.CGColor
        }
    }
    
    private let width: CGFloat = 50
    private let height: CGFloat = 50
    private let radius: CGFloat = 25
    private let lineWidth: CGFloat = 4
    
    private let circleLayer = CAShapeLayer()
    private let checkMarkLayer = CAShapeLayer()
    private let grayCircleLayer = CAShapeLayer()
    private let crossLeftLayer = CAShapeLayer()
    private let crossRightLayer = CAShapeLayer()
    
    private let animationDuration = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    
    func commonInit() {
        
        createCheckmarkLayer()
        createCirclesLayer()
        createCrossLayer()
        
    }
    
    func createCheckmarkLayer(){
        
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        
        let checkmarkPath = UIBezierPath()
        
        x = radius - radius * sin(0.25 * CGFloat(M_PI))
        y = x
        let startPoint = CGPointMake(x, y)
        checkmarkPath.moveToPoint(startPoint)
        
        x = radius
        y = radius*1.2
        let midPoint = CGPointMake(x, y)
        checkmarkPath.addLineToPoint(midPoint)
        
        x = radius + radius * sin(0.25 * CGFloat(M_PI))
        y = radius - radius * sin(0.25 * CGFloat(M_PI))
        let endPoint = CGPointMake(x, y)
        checkmarkPath.addLineToPoint(endPoint)
        
        checkMarkLayer.path = checkmarkPath.CGPath
        checkMarkLayer.lineWidth = lineWidth
        checkMarkLayer.lineCap = kCALineCapRound
        checkMarkLayer.lineJoin = kCALineJoinRound
        checkMarkLayer.fillColor = UIColor.clearColor().CGColor
        checkMarkLayer.strokeEnd = 0.0
        checkMarkLayer.strokeStart = 0.0
        layer.addSublayer(checkMarkLayer)
    }
    
    func createCirclesLayer() {
        let circlePath = UIBezierPath()
        circlePath.addArcWithCenter(CGPointMake(width/2, height/2), radius: radius, startAngle: 1.25*CGFloat(M_PI), endAngle: 3.25*CGFloat(M_PI), clockwise: false) // start = 225 end = 585
        
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = lineWidth
        layer.addSublayer(circleLayer)
        
        
        grayCircleLayer.path = circlePath.CGPath
        grayCircleLayer.fillColor = UIColor.clearColor().CGColor
        grayCircleLayer.opacity = 0.4
        grayCircleLayer.lineWidth = lineWidth
        layer.addSublayer(grayCircleLayer)
    }
    
    func createCrossLayer() {
        
        let crossLeftPath = UIBezierPath()
        
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        
        x = radius - radius * sin(0.25 * CGFloat(M_PI))
        y = x
        var startPoint = CGPointMake(x, y)
        crossLeftPath.moveToPoint(startPoint)
        
        x = 2 * radius - x
        y = 2 * radius - y
        var endPoint = CGPointMake(x, y)
        crossLeftPath.addLineToPoint(endPoint)
        
        crossLeftLayer.path = crossLeftPath.CGPath
        crossLeftLayer.lineWidth = lineWidth
        crossLeftLayer.lineCap = kCALineCapRound
        crossLeftLayer.fillColor = UIColor.clearColor().CGColor
        crossLeftLayer.strokeStart = 0
        crossLeftLayer.strokeEnd = 0
        layer.addSublayer(crossLeftLayer)
        
        
        let crossRightPath = UIBezierPath()
        
        x = radius + radius * sin(0.25 * CGFloat(M_PI))
        y = radius - radius * sin(0.25 * CGFloat(M_PI))
        startPoint = CGPointMake(x, y)
        crossRightPath.moveToPoint(startPoint)
        
        x = y
        y = radius + radius * sin(0.25 * CGFloat(M_PI))
        endPoint = CGPointMake(x, y)
        crossRightPath.addLineToPoint(endPoint)
        
        crossRightLayer.path = crossRightPath.CGPath
        crossRightLayer.lineWidth = lineWidth
        crossRightLayer.lineCap = kCALineCapRound
        crossRightLayer.fillColor = UIColor.clearColor().CGColor
        crossRightLayer.strokeStart = 0
        crossRightLayer.strokeEnd = 0
        layer.addSublayer(crossRightLayer)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    
    func circleAnimation(withColor color:UIColor, animation:Bool){
        
        circleLayer.strokeColor = color.CGColor
        grayCircleLayer.strokeColor = color.CGColor
        
        let circleStrokeStart = CABasicAnimation(keyPath: "strokeStart")
        circleStrokeStart.duration = 0.8 * animationDuration
        circleStrokeStart.beginTime = 0.0
        circleStrokeStart.fromValue = animation ? NSNumber(float: 0.0) : NSNumber(float: 1.1)
        circleStrokeStart.toValue   = animation ? NSNumber(float: 1.1) : NSNumber(float: 0.0)
        circleStrokeStart.removedOnCompletion = false
        circleStrokeStart.fillMode = kCAFillModeForwards
        circleLayer.addAnimation(circleStrokeStart, forKey: "CircleLayerAnimation")
    }
    
    internal var showAnimationCheck = false {
        didSet {
            
            circleAnimation(withColor: colorCheckmark, animation:showAnimationCheck)
            
            let markStrokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
            markStrokeEnd.duration = 0.8 * animationDuration
            markStrokeEnd.removedOnCompletion = false
            markStrokeEnd.fillMode = kCAFillModeForwards
            markStrokeEnd.calculationMode = kCAAnimationPaced
            markStrokeEnd.values = showAnimationCheck ? [0.0,0.85] : [0.85,0.0]
            
            
            let markStrokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
            markStrokeStart.duration = 0.3 * animationDuration
            markStrokeStart.removedOnCompletion = false
            markStrokeStart.fillMode = kCAFillModeForwards
            markStrokeStart.values = showAnimationCheck ? [0.0,0.3] : [0.3,0.0]
            if showAnimationCheck {
                markStrokeStart.beginTime = 0.6 * animationDuration
            }
            
            
            let checkMarkAnimationGroup = CAAnimationGroup()
            checkMarkAnimationGroup.removedOnCompletion = false
            checkMarkAnimationGroup.fillMode = kCAFillModeForwards
            checkMarkAnimationGroup.duration = animationDuration
            checkMarkAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            checkMarkAnimationGroup.animations = [markStrokeEnd,markStrokeStart]
            checkMarkAnimationGroup.delegate = self
            checkMarkAnimationGroup.setValue(showAnimationCheck ? "CheckAnimation" : "ReverseCheck", forKey: "type")
            
            checkMarkLayer.hidden = false
            checkMarkLayer.addAnimation(checkMarkAnimationGroup, forKey: "checkMarkAnimation")
            
        }
    }
    
    
    internal var showAnimationCross = false {
        didSet {
            
            circleAnimation(withColor: colorCross, animation:showAnimationCross)
            
            crossRightLayer.hidden = false
            crossLeftLayer.hidden = false
            
            let strokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
            strokeEnd.duration = 0.8 * animationDuration
            strokeEnd.removedOnCompletion = false
            strokeEnd.fillMode = kCAFillModeForwards
            strokeEnd.calculationMode = kCAAnimationPaced
            strokeEnd.values = showAnimationCross ? [0.0,0.8] : [0.8,0.0]
            
            let strokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
            strokeStart.duration = 0.3 * animationDuration
            strokeStart.removedOnCompletion = false
            strokeStart.fillMode = kCAFillModeForwards
            strokeStart.values = showAnimationCross ? [0.0,0.2] : [0.2,0.0]
            if showAnimationCross {
                strokeStart.beginTime = 0.4 * animationDuration
            }
            
            let groupAnimation = CAAnimationGroup()
            groupAnimation.removedOnCompletion = false
            groupAnimation.fillMode = kCAFillModeForwards
            groupAnimation.duration = animationDuration
            groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            groupAnimation.animations = [strokeEnd, strokeStart]
            
            crossLeftLayer.addAnimation(groupAnimation, forKey: nil)
            
            groupAnimation.beginTime = 0
            groupAnimation.setValue(showAnimationCross ? "CrossAnimation" : "ReverseCross", forKey: "type")
            groupAnimation.delegate = self
            crossRightLayer.addAnimation(groupAnimation, forKey: nil)
            
        }
    }
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let type = anim.valueForKey("type") as? String {
            
            if type == "CheckAnimation" {
                showAnimationCheck = false
            }
            else if type == "ReverseCheck"  {
                checkMarkLayer.hidden = true
            }
            else if type == "CrossAnimation" {
                showAnimationCross = false
            }
            else if type == "ReverseCross" {
                crossRightLayer.hidden = true
                crossLeftLayer.hidden = true
                
            }
            
        }
    }

    
    
}
