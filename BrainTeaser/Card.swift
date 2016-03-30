//
//  Card.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 25/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit

class Card: UIView {

    let shapes = ["shape1","shape2","shape3"]
    
    var currentShape:String!
    
    @IBOutlet weak var shapeImageView:UIImageView!
    
    @IBInspectable var cornerRadius:CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
        selectShape()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        
        self.setNeedsLayout()
    }

    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(UInt32(shapes.count)))]
        shapeImageView.image = UIImage(named: currentShape)
        
    }

}
