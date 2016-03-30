//
//  CustomText.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 19/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit

@IBDesignable
class CustomText:UITextField {
    
    @IBInspectable var inset:CGFloat = 0
    @IBInspectable var cornerRadius:CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    override func awakeFromNib() {
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
    
}