//
//  JUSTCODE.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/27/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

/*

import Foundation
import UIKit


func initGradient() {
    gradient = CAGradientLayer()
    let gradientColors = [UIColor.blueColor().CGColor, UIColor.blueColor().CGColor]
    let startPoint = CGPoint(x: 1.0, y: 1.0)
    let endPoint = CGPoint(x: 1.0, y: 0.0)
    let locations = [NSNumber(double: 0.0), NSNumber(double: 0.5)]
    let gradientInitialFrame = CGRect(x: 0.0, y: 0.0, width: mainView.bounds.width+5.0, height: mainView.bounds.height) ///kostilik
    
    setupGradient(gradientView.layer, frame: gradientInitialFrame, gradient: gradient, colors: gradientColors, locations: locations, startPoint: startPoint, endPoint: endPoint, zPosition: -100)
}

func animateGradient(gradient gradient: CAGradientLayer, animKeyPath: String, from: AnyObject, to: AnyObject, duration: CFTimeInterval, repeatCount: Float, autoreverse: Bool, timingFunc: CAMediaTimingFunction, beginTime: CFTimeInterval = 0.0, deleg: AnyObject?, animName: String?) {
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
    animation.delegate = qVController
    animation.setValue(animName, forKey: "name")
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
    gradientAnimationGroup.delegate = self
    gradientAnimationGroup.duration = 30.0
    gradientAnimationGroup.repeatCount = Float.infinity
    gradientAnimationGroup.autoreverses = true
    gradientAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    gradientAnimationGroup.animations = [gradientAnimationLocations, gradientAnimationColors, gradientAnimationStartPointX, gradientAnimationStartPointY]
    
    gradient.addAnimation(gradientAnimationGroup, forKey: "GradientComplexAnimation")
}


func myGradientAnimation(delegate: UIViewController?) {
    let duration = 4.0
    animateGradient(gradient: gradient, animKeyPath: "colors", from: [UIColor.blackColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor], to: [UIColor.blueColor().CGColor, UIColor.blackColor().CGColor, UIColor.whiteColor().CGColor], duration: duration, repeatCount: Float.infinity, autoreverse: true, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), deleg: delegate!, animName: "anim2")
    
    animateGradient(gradient: gradient, animKeyPath: "startPoint.x", from: gradient.startPoint.x, to: 1.0, duration: duration, repeatCount: 1, autoreverse: false, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), deleg: delegate!, animName: "anim1")
    
    animateGradient(gradient: gradient, animKeyPath: "startPoint.y", from: gradient.startPoint.y, to: 1.0, duration: duration, repeatCount: 1, autoreverse: false, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), deleg: delegate!, animName: "anim")
}

//    [self.view.layer insertSublayer:gradient atIndex:0];



//UIColor.init(colorLiteralRed: 0.0, green: 0.0, blue: 0.25*Float(arc4random())/Float(UINT32_MAX), alpha: 1.0).CGColor   -   random color

func gradientDefaultAnimationSetup(delegate: UIViewController?) {
    animateGradient(gradient: gradient, animKeyPath: "colors", from: [UIColor.blueColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor], to: [UIColor.blueColor().CGColor, UIColor.blackColor().CGColor, UIColor.blueColor().CGColor], duration: 10, repeatCount: Float.infinity, autoreverse: true, timingFunc: CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), deleg: delegate!, animName: "anim2")
    
    
}

 
 */
