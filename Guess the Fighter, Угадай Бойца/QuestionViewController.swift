//
//  QuestionViewController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/14/16.
//  Copyright © 2016 piqapp. All rights reserved.

///FONTS///

// Avenir-LightOblique  AvenirNext-UltraLight Didot-Bold HelveticaNeue-UltraLight PingFangHK-Ultralight PingFangTC-Thin


import UIKit

func setupGradient(layerAttachTo: CALayer, frame: CGRect, gradient: CAGradientLayer, colors: [CGColor], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint, zPosition: Float) {
    
    gradient.frame = frame
    gradient.colors = colors
    gradient.locations = locations
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.zPosition = CGFloat(zPosition)
    layerAttachTo.addSublayer(gradient)
}

class QuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBOutlet var signX: [UIImageView]!
    
    var gradient: CAGradientLayer!
    var theGameController: GameController!
    
    var currentSelectedAnswer: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                ///pickerData = ["Manny Paquiao", "Freddy Roach", "Oscar De La Hoya", "Buakaw Banchamek", "Roy Jones"]
        //pickerData = ["MMMPPP", "FFFEEE", "CCCMMM", "MMMTTT", "DDDAAA", "BBBPPP"]
        
        gradient = CAGradientLayer()
        theGameController = GameController(debugLabel: testLabel)
        
        let gradientColors = [UIColor.magentaColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor]
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 1.0, y: 0.0)
        let locations = [NSNumber(double: 0.0), NSNumber(double: 0.2), NSNumber(double: 0.4)]
        
        setupGradient(gradientView.layer, frame: mainView.bounds, gradient: gradient, colors: gradientColors, locations: locations, startPoint: startPoint, endPoint: endPoint, zPosition: -100)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //animateGradientPredefined(gradient)
        //myGradientAnimation()
    }
    override func viewWillAppear(animated: Bool) { //viberaem centralniy element po umolchaniyu
        picker.selectRow(self.theGameController.answerListCount/2, inComponent: 0, animated: true)
        self.currentSelectedAnswer = self.theGameController.currentAnswerListData[self.theGameController.answerListCount/2]
        testLabel.text = self.theGameController.currentAnswerListData[self.theGameController.answerListCount/2]
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
        title = self.theGameController.currentAnswerListData[row]

        ///picker rows color and text
        let thetitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "PingFangTC-Thin", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
    
        let hue = CGFloat(1)/CGFloat(2) + CGFloat(row)/100
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        
        pickerLabel.textAlignment = .Center
        pickerLabel.attributedText = thetitle
        
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //let label = pickerView.viewForRow(row, forComponent: component) as! UILabel
        //label.text = "???????"
        self.currentSelectedAnswer = self.theGameController.currentAnswerListData[row]
        self.testLabel.text = self.theGameController.currentAnswerListData[row]
    }
    
    func gameOverFunc() {
        let notifController = UIAlertController(title: "GAME OVER", message: "Good luck. Try again!", preferredStyle: .Alert)
        let buttonOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
        notifController.addAction(buttonOk)
        
        presentViewController(notifController, animated: true, completion: nil)
    }
    
    func hideXsignIfWrong() {
        switch (self.theGameController.triesLeft) {
        case 2:
            self.signX[2].hidden = true
            break
        case 1:
            self.signX[1].hidden = true
            break
        case 0:
            self.signX[0].hidden = true
            break
        default:
            return
        }
    }
    
    @IBAction func answerButton(sender: UIButton) {
        myGradientAnimation()
        self.testLabel.text = self.theGameController.checkRightOrWrong(answer: self.currentSelectedAnswer).description
        
        let rightOrWrong = self.theGameController.checkRightOrWrong(answer: self.currentSelectedAnswer)
        if rightOrWrong == false {
            //esli oshibsya
            
            self.theGameController.oneTryLost(gameOverFunc())
            self.hideXsignIfWrong()
            
        } else {
            //otvetil pravilno
            //+ochki
        }
        
        
    }
    
    @IBAction func returnToQuestionViewController(segue: UIStoryboardSegue) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// GRADIENT ///////////
    
    func animateGradient(gradient gradient: CAGradientLayer, animKeyPath: String, from: AnyObject, to: AnyObject, duration: CFTimeInterval, repeatCount: Float, autoreverse: Bool, timingFunc: CAMediaTimingFunction, beginTime: CFTimeInterval = 0.0) {
        var animation: CABasicAnimation!
        switch (animKeyPath) {
        case "colors":
            animation = CABasicAnimation(keyPath: "colors")
            let fromArr = from as! [CGColor]
            let toArr = to as! [CGColor]
            animation.fromValue = fromArr
            animation.toValue = toArr
            break
        case "locations":
            animation = CABasicAnimation(keyPath: "locations")
            let fromArr = from as! [NSNumber]
            let toArr = to as! [NSNumber]
            animation.fromValue = fromArr
            animation.toValue = toArr
            break
        case "startPoint.x":
            animation = CABasicAnimation(keyPath: "startPoint.x")
            let fromArr = from as! Float
            let toArr = to as! Float
            animation.fromValue = fromArr
            animation.toValue = toArr
            break
        case "startPoint.y":
            animation = CABasicAnimation(keyPath: "startPoint.y")
            let fromArr = from as! Float
            let toArr = to as! Float
            animation.fromValue = fromArr
            animation.toValue = toArr
            break
        default:
            return
        }
        
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = autoreverse
        animation.timingFunction = timingFunc
        animation.beginTime = beginTime
        gradient.addAnimation(animation, forKey: nil)
    }

    func animateGradientPredefined(gradient: CAGradientLayer) {
        //locations
        let gradientAnimationLocations = CABasicAnimation(keyPath: "locations")
        gradientAnimationLocations.fromValue = [0.0, 0.0, 0.2]
        gradientAnimationLocations.toValue = [0.8, 1.0, 1.0]
        //colors
        let gradientAnimationColors = CABasicAnimation(keyPath: "colors")
        gradientAnimationColors.fromValue = [UIColor.blackColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor]
        gradientAnimationColors.toValue = [UIColor.magentaColor().CGColor, UIColor.whiteColor().CGColor, UIColor.blueColor().CGColor]
        //startPoint.x
        let gradientAnimationStartPointX = CABasicAnimation(keyPath: "startPoint.x")
        gradientAnimationStartPointX.fromValue = 0.0
        gradientAnimationStartPointX.toValue = 0.0
        
        //startPoint.y
        let gradientAnimationStartPointY = CABasicAnimation(keyPath: "startPoint.y")
        gradientAnimationStartPointY.fromValue = 0.0
        gradientAnimationStartPointY.toValue = 0.0
        
        //group
        let gradientAnimationGroup = CAAnimationGroup()
        gradientAnimationGroup.duration = 30.0
        gradientAnimationGroup.repeatCount = Float.infinity
        gradientAnimationGroup.autoreverses = true
        gradientAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        gradientAnimationGroup.animations = [gradientAnimationLocations, gradientAnimationColors, gradientAnimationStartPointX, gradientAnimationStartPointY]
        
        gradient.addAnimation(gradientAnimationGroup, forKey: "GradientComplexAnimation")
    }

    
    func myGradientAnimation() {
        
        animateGradient(gradient: gradient, animKeyPath: "colors", from: [UIColor.blackColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor], to: [UIColor.blueColor().CGColor, UIColor.blackColor().CGColor, UIColor.whiteColor().CGColor], duration: 4, repeatCount: Float.infinity, autoreverse: true, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        
        animateGradient(gradient: gradient, animKeyPath: "startPoint.x", from: gradient.startPoint.x, to: 0.99, duration: 4, repeatCount: 1, autoreverse: false, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
        animateGradient(gradient: gradient, animKeyPath: "startPoint.y", from: gradient.startPoint.y, to: 0.99, duration: 4, repeatCount: 1, autoreverse: false, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
    }
    
}






