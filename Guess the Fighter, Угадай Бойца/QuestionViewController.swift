//
//  QuestionViewController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/14/16.
//  Copyright © 2016 piqapp. All rights reserved.

///FONTS///

// Avenir-LightOblique  AvenirNext-UltraLight Didot-Bold HelveticaNeue-UltraLight PingFangHK-Ultralight PingFangTC-Thin


import UIKit



class QuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    
   
    var gradient: CAGradientLayer!
    var theGameController: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                ///pickerData = ["Manny Paquiao", "Freddy Roach", "Oscar De La Hoya", "Buakaw Banchamek", "Roy Jones"]
        //pickerData = ["MMMPPP", "FFFEEE", "CCCMMM", "MMMTTT", "DDDAAA", "BBBPPP"]
        
        gradient = CAGradientLayer()
        theGameController = GameController()
        
        let gradientColors = [UIColor.magentaColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor]
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 1.0, y: 0.0)
        let locations = [NSNumber(double: 0.0), NSNumber(double: 0.2), NSNumber(double: 0.4)]
        
        setupGradient(gradientView.layer, frame: mainView.bounds, gradient: gradient, colors: gradientColors, locations: locations, startPoint: startPoint, endPoint: endPoint, zPosition: -100)
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //animateGradient(gradient)
        myGradientAnimation()
    }
    
    override func viewWillAppear(animated: Bool) {
        picker.selectRow(self.theGameController.answerListCount, inComponent: 0, animated: true)
        //picker.selectRow(Int(self.theGameController.AnswerListCount), inComponent: 0, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.theGameController.answerListCount
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let title: String!
        title = self.theGameController.currentFighter.name
        
        // Avenir-LightOblique  AvenirNext-UltraLight Didot-Bold HelveticaNeue-UltraLight PingFangHK-Ultralight PingFangTC-Thin
        ///picker rows color and text
        let thetitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "PingFangTC-Thin", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
    
        let hue = CGFloat(1)/CGFloat(2) + CGFloat(row)/50
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        
        pickerLabel.textAlignment = .Center
        pickerLabel.attributedText = thetitle
        
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let label = pickerView.viewForRow(row, forComponent: component) as! UILabel
        label.text = "???????"
        
    }
    
    @IBAction func answerButton(sender: UIButton) {
        myGradientAnimation()
    }
    
    @IBAction func returnToQuestionViewController(segue: UIStoryboardSegue) {
        
    }
    
    func myGradientAnimation() {
        
        animateGradient(gradient: gradient, animKeyPath: "colors", from: [UIColor.blackColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor], to: [UIColor.blueColor().CGColor, UIColor.blackColor().CGColor, UIColor.whiteColor().CGColor], duration: 4, repeatCount: Float.infinity, autoreverse: true, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        
        animateGradient(gradient: gradient, animKeyPath: "startPoint.x", from: gradient.startPoint.x, to: 0.99, duration: 4, repeatCount: 1, autoreverse: true, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
        animateGradient(gradient: gradient, animKeyPath: "startPoint.y", from: gradient.startPoint.y, to: 0.99, duration: 4, repeatCount: 1, autoreverse: true, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
    }
    
}
