//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 19/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomButtom: UIButton {
    
    @IBInspectable var cornerRadius:CGFloat = 3.0 {
        didSet {
            setUpView()
        }
    }
    
    
    @IBInspectable var fontColor:UIColor = UIColor.whiteColor() {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        setUpView()
        self.addTarget(self, action: #selector(CustomButtom.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(CustomButtom.scaleToSmall), forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: #selector(CustomButtom.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(CustomButtom.scaleDefault), forControlEvents: .TouchDragExit)
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
        tintColor = fontColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func scaleToSmall(){
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    
    func scaleAnimation() {
        let scale = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scale.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scale.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0)) // Back to normal
        scale.springBounciness = 18.0
        layer.pop_addAnimation(scale, forKey: "layerScaleSpringAnimation")
    }
    
    
    func scaleDefault() {
        let scale = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scale.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(scale, forKey: "layerScaleDefaultAnimation")
    }
    
    
    
    
    
    
    
}
