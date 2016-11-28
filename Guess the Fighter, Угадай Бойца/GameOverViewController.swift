//
//  GameOverViewController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/27/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(theGameController.checkIfHighScore(theGameController.score) == true) {
            //newHighScoreAnimation()
            highScoreLabel.text = theGameController.highscore.description
            scoreLabel.text = theGameController.highscore.description
        }
        
        scoreLabel.text = theGameController.score.description
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retryButtonHandler(sender: UIButton) {
        theGameController.playSound("CLICK")
        theGameController.restartGame()
    }

    @IBAction func mainMenuButtonHandler(sender: UIButton) {
        theGameController.playSound("CLICK")
        theGameController.restartGame()
    }
    
    func newHighScoreAnimation() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
