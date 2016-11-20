//
//  GradientKFR.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/17/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import Foundation
import UIKit

////////// NODEPENDENCIES ////////////////////////

func setupGradient(layerAttachTo: CALayer, frame: CGRect, gradient: CAGradientLayer, colors: [CGColor], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint, zPosition: Float) {
    
    gradient.frame = frame
    gradient.colors = colors
    gradient.locations = locations
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.zPosition = CGFloat(zPosition)
    layerAttachTo.addSublayer(gradient)
}

func gradientSetNewLocations(gradient gradient: CAGradientLayer, newLocations: [NSNumber]) {
    gradient.locations = newLocations
}

func gradientSetNewColors(gradient gradient: CAGradientLayer, newColors: [CGColor]) {
    gradient.colors = newColors
}


func animateGradient(gradient gradient: CAGradientLayer, animKeyPath: String, from: AnyObject, to: AnyObject, duration: CFTimeInterval, repeatCount: Float, autoreverse: Bool, timingFunc: CAMediaTimingFunction) {
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
    gradient.addAnimation(animation, forKey: nil)
}



/*
func animateGradientColors(gradient gradient: CAGradientLayer, fromClrs: [CGColor], toClrs: [CGColor], duration: CFTimeInterval, repeatCount: Float, autoreverse: Bool, timingFunc: CAMediaTimingFunction) {
    let animateColors = CABasicAnimation(keyPath: "colors")
    animateColors.fromValue = fromClrs
    animateColors.toValue = toClrs
    animateColors.duration = duration
    animateColors.repeatCount = repeatCount
    animateColors.autoreverses = autoreverse
    animateColors.timingFunction = timingFunc
    gradient.addAnimation(animateColors, forKey: nil)
}

func animateGradientLocations(gradient gradient: CAGradientLayer, fromLoc: [NSNumber], toLoc: [NSNumber], duration: CFTimeInterval, repeatCount: Float, autoreverse: Bool, timingFunc: CAMediaTimingFunction) {
    let animateLocations = CABasicAnimation(keyPath: "locations")
    animateLocations.fromValue = fromLoc
    animateLocations.toValue = toLoc
    animateLocations.duration = duration
    animateLocations.repeatCount = repeatCount
    animateLocations.autoreverses = autoreverse
    animateLocations.timingFunction = timingFunc
    gradient.addAnimation(animateLocations, forKey: nil)
}

func animateGradientStartPointX(gradient gradient: CAGradientLayer, fromVal: Float, toVal: Float, duration: CFTimeInterval, repeatCount: Float, autoreverse: Bool, timingFunc: CAMediaTimingFunction) {
    let animateStartPointX = CABasicAnimation(keyPath: "startPoint.x")
    animateStartPointX.fromValue = fromVal
    animateStartPointX.toValue = toVal
    animateStartPointX.duration = duration
    animateStartPointX.repeatCount = repeatCount
    animateStartPointX.autoreverses = autoreverse
    animateStartPointX.timingFunction = timingFunc
    gradient.addAnimation(animateStartPointX, forKey: nil)
}

*/

//////////////////////////////////////////////////







func animateGradient(gradient: CAGradientLayer) {
    //locations
    let gradientAnimationLocations = CABasicAnimation(keyPath: "locations")
    gradientAnimationLocations.fromValue = [0.0, 0.0, 0.2]
    gradientAnimationLocations.toValue = [0.8, 1.0, 1.0]
    //colors
    let gradientAnimationColors = CABasicAnimation(keyPath: "colors")
    gradientAnimationColors.fromValue = [UIColor.blueColor().CGColor, UIColor.blackColor().CGColor, UIColor.magentaColor().CGColor]
    gradientAnimationColors.toValue = [UIColor.whiteColor().CGColor, UIColor.magentaColor().CGColor, UIColor.blueColor().CGColor]
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
    gradientAnimationGroup.duration = 4.0
    gradientAnimationGroup.repeatCount = Float.infinity
    gradientAnimationGroup.autoreverses = true
    gradientAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    gradientAnimationGroup.animations = [gradientAnimationLocations, gradientAnimationColors, gradientAnimationStartPointX, gradientAnimationStartPointY]
    
    gradient.addAnimation(gradientAnimationGroup, forKey: "GradientComplexAnimation")
}


