//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Ugo Besa on 25/03/2016.
//  Copyright © 2016 Ugo Besa. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet private weak var yesBtn:CustomButtom!
    @IBOutlet private weak var noBtn:CustomButtom!
    @IBOutlet private weak var titleLbl:UILabel!
    @IBOutlet weak var checkmarkView: Checkmark!
    @IBOutlet weak var timerView:TimerView!
    @IBOutlet weak var scorelbl: UILabel!
    
    var currentCard: Card!
    var previousCard: Card?
    
    var goodAnswers = 0
    var badAnswers = 0
    var isNewGame = true

    override func viewDidLoad() {
        super.viewDidLoad()

        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }
    
    
    
    @IBAction func yesPressed(sender: UIButton) {
        
        if isNewGame {
            
            isNewGame = false
            titleLbl.text = "Does this card match the previous one ?"
            yesBtn.setTitle("YES", forState: .Normal)
            noBtn.hidden = false
            checkmarkView.hidden = false
            scorelbl.hidden = true
            
            timerView.startTimer({
                self.scorelbl.hidden = false
                self.scorelbl.text = "Final Score: \(self.goodAnswers)/\(self.goodAnswers + self.badAnswers). Do better!"
                self.titleLbl.text = "Remember this card"
                self.yesBtn.setTitle("RESTART", forState: .Normal)
                self.noBtn.hidden = true
                self.isNewGame = true
                self.checkmarkView.hidden = true
            })
        }
        else{
            checkAnswer(true)
            showNextCard()
        }
    }
    
    @IBAction func noPressed(sender: UIButton){
        
        checkAnswer(false)
        showNextCard()
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            previousCard = currentCard
            currentCard = nil  // here data manipulation
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenRightPosition, completion: { (anim:POPAnimation!, finsihed:Bool!) in
                // Don't do currentCard = nil here because don't do data manipulation with animations
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenLeftPosition
            self.view.addSubview(next)
            currentCard = next
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: nil)
        }
    }
    
    func createCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    func checkAnswer(saidYes:Bool) {
        
        if saidYes {
            if previousCard?.currentShape == currentCard.currentShape {
                checkmarkView.showAnimationCheck = true
                goodAnswers += 1
            }
            else {
                checkmarkView.showAnimationCross = true
                badAnswers += 1
            }
        }
        else{
            if previousCard?.currentShape != currentCard.currentShape {
                checkmarkView.showAnimationCheck = true
                goodAnswers += 1
            }
            else {
                checkmarkView.showAnimationCross = true
                badAnswers += 1
            }
        }
        
    }
    
    
    
    
    
    
    

   

}
