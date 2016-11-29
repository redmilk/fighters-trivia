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



var qVController: QuestionViewController!

class QuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var signX: [UIImageView]!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var congratStrip: UIStackView!
    //@IBOutlet weak var dotsStack: UIStackView!
    
    
    var gradient: CAGradientLayer!
    var currentSelectedAnswer: String!
    var currentRowIndex: Int = 0
    var congratStripOpenConstraint: NSLayoutConstraint!
    var congratStripCloseConstraint: NSLayoutConstraint!
    
    var answerStripOpenConstraint: NSLayoutConstraint!
    var answerStripCloseConstraint: NSLayoutConstraint!
    
    var answerButtonAllowedToPress: Bool = true
    
    /////////////////////////// VIEW /////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.answerButtonGradient()
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.blueColor().CGColor, UIColor.greenColor().CGColor, UIColor.blueColor().CGColor]
        gradient.locations = [0.0 , 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.2)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.8)
        
        /// ( gradien uvilichivaem v shirinu dvoe i stavim po centru (x: - fra.siz.wi) )
        
        
        gradient.frame = CGRect(x: -self.view.frame.size.width/3, y: 0.0, width: self.view.frame.size.width*3, height: self.view.frame.size.height)
        gradient.zPosition = -10
        
        self.gradientView.layer.addSublayer(gradient)
        
        
        
        theGameController = GameController(debugLabel: self.testLabel, scoreLabel: self.scoreLabel)
        qVController = self
        
        congratStripOpenConstraint = NSLayoutConstraint(item: congratStrip, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 0.3, constant: 0.0) /// wtf 0.3 a ne 0.2
        
        congratStripCloseConstraint = NSLayoutConstraint(item: congratStrip, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 0.0, constant: 0.0)
        
        answerStripOpenConstraint = NSLayoutConstraint(item: answerButton, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 0.2, constant: 0.0)
        
        answerStripCloseConstraint = NSLayoutConstraint(item: answerButton, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 0.0, constant: 0.0)
        
        congratStripCloseConstraint.active = true
        answerStripOpenConstraint.active = true
        
        //gradientView.backgroundColor = UIColor.blueColor()
        
    }
    override func viewDidAppear(animated: Bool) {
        ///start animations here
         self.gradientBackgroundColorAnimation()
        self.gradientBackgroundChangePositionAnimation()
    }
    override func viewWillAppear(animated: Bool) {
        setNewImage(theGameController.currentFighter.image)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///////////////////////// PICKER VIEW DELEGATE//////////////// PICKER VIEW DELEGATE//////////////////
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theGameController.answerListCount
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let title: String!
        title = theGameController.currentAnswerListData[row]
        ///picker rows color and text
        let thetitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "PingFangTC-Thin", size: 26.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        let hue = CGFloat(0.70)
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        pickerLabel.textAlignment = .Center
        pickerLabel.attributedText = thetitle
        return pickerLabel
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.currentRowIndex != row {    ///esli smestilis na novuyu yacheiku
            theGameController.playSound("SCROLL")
            self.answerButtonAllowedToPress = true
        }
        self.currentRowIndex = row
        self.currentSelectedAnswer = theGameController.currentAnswerListData[row]
        self.testLabel.text = self.currentSelectedAnswer
        
        
    }
    
    ////////////////////// ANIMATION DELEGATE ///////////////////////////////////////////////////////////
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let name = anim.valueForKey("name") as? String {
            if name == "seekLocation" {
                ///somnitelno
                self.gradient.locations = [0.0, self.picker.selectedRowInComponent(0)/5, 1.0]
                
            }
        }
    }
    
    //////////////////////////////////////////// CUSTOM FUNCTIONS ///////////////////////////////////////
    
    func doSegueWithIdentifier(identif: String)
    {
        performSegueWithIdentifier(identif, sender: nil)
    }
    
    ///parametr lishniy         ///GRADIENT COLOR CHANGE IF WRONG
    func backGroundColorChangeAnimationOnAnswer(playerAnswerResult: String) {
        
        let anim = CABasicAnimation(keyPath: "colors")
        anim.toValue = [UIColor.blueColor().CGColor, UIColor.redColor().CGColor, UIColor.blueColor().CGColor]
        anim.fromValue = [UIColor.redColor().CGColor, UIColor.redColor().CGColor, UIColor.redColor().CGColor]
        anim.duration = 1.5
        anim.repeatCount = 1
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        self.gradient.addAnimation(anim, forKey: nil)
        
        /// Predidushiy variant animacii pri oshibke v otvete. bckr s krasnogo na siniy
        
        /*let anim = CABasicAnimation(keyPath: "backgroundColor")
         
         switch playerAnswerResult {
         case "WRONG":
         anim.fromValue = UIColor.redColor().CGColor
         break
         default: break
         }
         anim.toValue = UIColor.blueColor().CGColor
         anim.duration = 1.5
         anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
         anim.repeatCount = 1
         self.gradientView.bacgroundcolor = blueColor()
         */
    }
    
    ///GRADIENT BACGR MIDDLE STRIP ANIM COLOR CHANGE   /// unused
    func gradientBackgroundColorAnimation() {
        
        let anim = CABasicAnimation(keyPath: "colors")
        ///1.
        //anim.fromValue = [UIColor.blueColor().CGColor, UIColor.greenColor().CGColor, UIColor.blueColor().CGColor]
        //anim.toValue = [UIColor.cyanColor().CGColor, UIColor.blueColor().CGColor, UIColor.cyanColor().CGColor]
        
        anim.fromValue = [UIColor.blueColor().CGColor, UIColor.redColor().CGColor, UIColor.blueColor().CGColor]
        anim.toValue = [UIColor.redColor().CGColor, UIColor.blueColor().CGColor, UIColor.redColor().CGColor]
        
        anim.duration = 7
        anim.repeatCount = Float.infinity
        anim.autoreverses = true
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.gradient.addAnimation(anim, forKey: nil)
    }
    
    /// GRADIENT BCGR CHANGE POSITION ANIMATION DEPENDS ON ROW SELECTED
    func gradientBackgroundChangePositionAnimation() {
        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = [0.0, 0.0, 0.25]
        anim.toValue = [0.75, 1.0, 1.0]
        anim.duration = 10
        //anim.autoreverses = true
        anim.repeatCount = Float.infinity
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.gradient.addAnimation(anim, forKey: nil)
    }
    
    
    func answerButtonSetState(state: String) {
        if theGameController.gameIsOver == true {
            return
        }
        switch state {
        case "OPEN":
            UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.7, options: [], animations: {
                if self.answerStripOpenConstraint.active == false {
                    self.answerStripOpenConstraint.active = true
                    self.answerStripCloseConstraint.active = false
                }
                self.view.layoutIfNeeded()
                self.answerButton.setTitle("NEXT", forState: .Normal)
                }, completion: { _ in
                    ///lishaet vozmozhnosti vibora pickera mezhdu voprosami (stranno pochemu tut ne false) *
                    self.picker.userInteractionEnabled = true
            })
            
            break
        case "CLOSE":
            UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.7, options: [], animations: {
                if self.answerStripCloseConstraint.active == false {
                    self.answerStripCloseConstraint.active = true
                    self.answerStripOpenConstraint.active = false
                }
                self.view.layoutIfNeeded()
                self.answerButton.setTitle("", forState: .Normal)
                }, completion: { _ in
                    /// tozhesamoe *
                    self.picker.userInteractionEnabled = false
            })
            break
        default:
            break
        }
        
    }
    
    func congratStripSetState(state: String) {
        if theGameController.gameIsOver == true {
            return
        }
        switch state {
        case "OPEN":
            UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [.CurveEaseInOut], animations: {
                if self.congratStripCloseConstraint.active == true {
                    self.congratStripCloseConstraint.active = false
                    self.congratStripOpenConstraint.active = true
                }
                self.view.layoutIfNeeded()
                
                }, completion: nil)
            
            break
        case "CLOSE":
            UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [.CurveEaseInOut], animations: {
                if self.congratStripOpenConstraint.active == true {
                    self.congratStripOpenConstraint.active = false
                    self.congratStripCloseConstraint.active = true
                }
                self.view.layoutIfNeeded()
                
                }, completion: nil)
            break
        default:
            break
        }
    }
    
    
    func changeFighterImageWithAnimation(imageView: UIImageView, toImage: UIImage) {
        if theGameController.gameIsOver == true {
            return
        }
        /*imageView.image = toImage
         let pos = imageView.layer.position.y
         let anim = CASpringAnimation(keyPath: "position.y")
         anim.damping = 8.5
         anim.initialVelocity = 15.0
         //anim.stiffness = 100.0
         anim.mass = 1.0
         anim.duration = anim.settlingDuration
         anim.fromValue = pos - 300.0
         anim.toValue = pos
         self.imageView.layer.addAnimation(anim, forKey: nil) */
        
        /// Transition between Question
        UIView.transitionWithView(imageView, duration: 0.4, options: .TransitionFlipFromLeft, animations: {
            
            imageView.image = toImage
            
            
            }, completion: { _ in
                
        })
        
    }
    
    func pickerSelectMiddleOption() {
        let index: Int = Int(theGameController.answerListCount/2)
        picker.selectRow(index, inComponent: 0, animated: true)
        self.currentSelectedAnswer = theGameController.currentAnswerListData[picker.selectedRowInComponent(0)]
        //testLabel.text = currentSelectedAnswer
    }
    
    func reloadPickerView() {
        self.picker.reloadAllComponents()
    }
    
    func setNewImage(imageName: String) {
        theGameController.playSound("CHANGEIMAGE")
        changeFighterImageWithAnimation(self.imageView, toImage: UIImage(named:imageName)!)
        pickerSelectMiddleOption()
        self.testLabel.text = currentSelectedAnswer
    }
    
    func gameOverAnimation() {  /// E
        
        congratStripOpenConstraint.active = false
        congratStripCloseConstraint.active = true
        print("GAME OVER ANIMATION")
    }
    
    func resetDots() {
        self.signX[2].image = UIImage(named: "singleDot")
        self.signX[1].image = UIImage(named: "singleDot")
        self.signX[0].image = UIImage(named: "singleDot")
        
    }
    
    func changeXtoDot() -> Void {
        switch (theGameController.triesLeft) {
        case 2:
            self.signX[2].image = UIImage(named: "X1")
            //self.signX[2].backgroundColor = UIColor.redColor()
            break
        case 1:
            self.signX[1].image = UIImage(named: "X1")
            //self.signX[1].backgroundColor = UIColor.redColor()
            break
        case 0:
            self.signX[0].image = UIImage(named: "X1")
            //self.signX[0].backgroundColor = UIColor.redColor()
            
            break
        default:
            break
        }
    }
    
    func answerButtonAnimationOnPress() {
        let anim = CASpringAnimation(keyPath: "transform.scale")
        anim.damping = 7.9
        anim.initialVelocity = 15.0
        //anim.stiffness = 100.0
        anim.mass = 1.0
        anim.duration = anim.settlingDuration
        anim.fromValue = 1.2
        anim.toValue = 1.0
        self.answerButton.layer.addAnimation(anim, forKey: nil)
    }
    
    
    ////////////////////////////// ANSWER BUTTON HANDLER /////////////////////// HANDLERS ////////////////
    
    @IBAction func answerButton(sender: UIButton) {
        if self.answerButtonAllowedToPress == false {
            return
        }
        answerButtonAnimationOnPress()
        testLabel.text = currentSelectedAnswer
        theGameController.checkRightOrWrong(answer: self.currentSelectedAnswer, changeXToDotFunc: self.changeXtoDot, gameOverFunc: self.gameOverAnimation)
        /// answer disable for pressing for 1 second
        self.disablePressAnswerButtonForTime()
    }
    
    @IBAction func returnToQuestionViewController(segue: UIStoryboardSegue) {
        
    }
    
    func disablePressAnswerButtonForTime () {
        self.answerButton.userInteractionEnabled = false
        let triggerTime = (Int64(NSEC_PER_SEC) * Int64(1))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.answerButton.userInteractionEnabled = true
        })
    }
    
    func answerButtonGradient() {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        let newFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.answerButton.bounds.height)
        gradient.frame = newFrame
        gradient.zPosition = -10
        gradient.colors = [
            UIColor.whiteColor().CGColor,
            UIColor.blueColor().CGColor
        ]
        
        /* repeat the central location to have solid colors */
        gradient.locations = [0, 1.0]
        
        /* make it horizontal */
        gradient.startPoint = CGPointMake(0, 1.0)
        gradient.endPoint = CGPointMake(1, 1)
        
        self.answerButton.layer.addSublayer(gradient)
    }
    
}