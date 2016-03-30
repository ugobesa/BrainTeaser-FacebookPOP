//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 24/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    // A class because it's static. One instance for the AnimationEngine
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width * 2, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    //CONSTANTS
    let ANIM_DELAY:Int64 = 1
    
    var originalConstants = [CGFloat]()
    var constraints = [NSLayoutConstraint]()
    
    init(constraints : [NSLayoutConstraint]){
        
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay:Int64?) {
        
        let d:Int64 = delay == nil ? Int64( Double(ANIM_DELAY) * Double(NSEC_PER_SEC)) : Int64(Double(delay!) * Double(NSEC_PER_SEC))
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(d))
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            var index = 0
            repeat {
                
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                if(index > 0){
                    moveAnim.dynamicsFriction += 15 + CGFloat(index)
                }
            
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
            }while(index < self.constraints.count)
        }
    }
    
    class func animateToPosition(view:UIView, position:CGPoint, completion: ((POPAnimation!, Bool) -> Void)?) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 8
        moveAnim.springSpeed = 8
        moveAnim.completionBlock = completion
        view.layer.pop_addAnimation(moveAnim, forKey: "moveToPosition")
        
        
    }
    
    
    
    
    
    
    
}
