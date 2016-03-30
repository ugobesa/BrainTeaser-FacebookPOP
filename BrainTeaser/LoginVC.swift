//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 17/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animEngine.animateOnScreen(1)
    }


}

