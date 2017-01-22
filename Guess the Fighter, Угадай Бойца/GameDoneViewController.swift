//
//  GameDoneViewController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/27/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import UIKit

class GameDoneViewController: UIViewController {

    @IBOutlet weak var giftButton: UIButton!
    
    var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///dlya togo chtobi gradient menyal orientaciyu pri izmenenii raskladki
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(QuestionViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)

        gradient = CAGradientLayer()
        gradient.colors = [UIColor.blueColor().CGColor, UIColor.redColor().CGColor, UIColor.blueColor().CGColor]
        gradient.locations = [0.0 , 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        gradient.zPosition = -10
        
        self.view.layer.addSublayer(gradient)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func giftButtonHandler() {
        theGameController.playSound("CLICK")
        performSegueWithIdentifier("showMainMenu", sender: nil)
    }
    
    ///dlya togo chtobi gradient menyal orientaciyu pri izmenenii raskladki
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            //print("landscape")
            ifOrientChanged()
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            //print("Portrait")
            ifOrientChanged()
        }
        
    }
    
    private func ifOrientChanged() {
        gradient.frame = self.view.bounds
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
