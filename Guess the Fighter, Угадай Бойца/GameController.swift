//
//  GameController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/14/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

var highScore: Int!

class GameController {
    private var fighters: [Fighter] = [Fighter]()
    var currentFighter: Fighter!
    
    var triesLeft: Int = 3
    var answerListCount: Int!
    var currentAnswerListData: [String]!
    var currentRightAnswerIndex: Int!
    var score: Int = 0
    
    var testLabel: UILabel!
    
    init(debugLabel: UILabel) {
        
        self.testLabel = debugLabel
        
        CURRENTQUESTIONINDEX = 0
        
        self.fighters = [Fighter(name: "Manny Paquiao", image: "pac1"),
                         Fighter(name: "Mike Tyson", image: "tyson1"),
                         Fighter(name: "Jon Jones", image: "jones1"),
                         Fighter(name: "Conor McGregor", image: "conor1"),
                         Fighter(name: "Lennox Lewis", image: "lewis1"),
                         Fighter(name: "Aleksandr Emelianenko", image: "aemelianenko1"),
                         Fighter(name: "Buakaw Banchamek", image: "buakaw1"),
                         Fighter(name: "Fedor Emelianenko", image: "fedor1"),
                         Fighter(name: "Batu Hasikov", image: "hasikov1"),
                         Fighter(name: "Evander Hollyfield", image: "hollyfield1"),
                         Fighter(name: "Artur Kyshenko", image: "kyshenko1"),
                         Fighter(name: "Denis Lebedev", image: "lebedev1"),
                         Fighter(name: "Vasiliy Lomachenko", image: "lomachenko1"),
                         Fighter(name: "Floyd Mayweather", image: "mayweather1"),
                         Fighter(name: "Aleksandr Povetkin", image: "povetkin1"),
                         Fighter(name: "Andy Souwer", image: "souwer1"),
                         Fighter(name: "Vladimir Klichko", image: "vklichko1"),
                         Fighter(name: "Mike Zambidis", image: "zambidis1"),
                         
        ]
        
        self.currentFighter = self.fighters[0]
        //self.testLabel.text = score.description
        self.answerListCount = 8
        self.currentAnswerListData = self.getRandomAnswers(howmany: answerListCount)
        self.currentRightAnswerIndex = generateRightAnswer()
        //qVController.pickerSelectMiddleOption()
    }
    
    ///VSE ZAVYAZANO NA INDEKSE, KOGDA EGO MENYAEM ON UPRAVLYAET IZMENENIEM OSTALNOGO
    ///kogda menyaem indeks tekushego voprosa, menyaetsya currentFighter na sootv.
    var CURRENTQUESTIONINDEX: Int {
        didSet {
            
            if CURRENTQUESTIONINDEX >= self.fighters.count {
                return
            }
            
            self.currentFighter = self.fighters[CURRENTQUESTIONINDEX]
            
            qVController.setNewImage(self.fighters[CURRENTQUESTIONINDEX].image)
            self.score += 1
            qVController.pickerSelectMiddleOption()
            //SHOW SCORE FUNC -->
            //self.testLabel.text = self.score.description
            self.currentAnswerListData = getRandomAnswers(howmany: self.answerListCount)
            self.currentRightAnswerIndex = generateRightAnswer()
            qVController.reloadPickerView()
            qVController.pickerSelectMiddleOption()
            self.testLabel.text = self.currentAnswerListData[self.answerListCount/2] }
    }
    
    
    //////////////////////////////// RIGHT OR WRONG /////////////////////////////////
    
    func checkRightOrWrong(answer answer: String, changeXToDotFunc: ( ) -> (Void), gameOverFunc: ( ) -> (Void)) {
        let result = currentFighter.name == answer
        if result == false {  //esli dopustil oshibku
            playSound("WRONG")
            if self.triesLeft - 1 >= 0 {
                self.triesLeft -= 1
                changeXToDotFunc()
            }
            if self.triesLeft <= 0 {
                playSound("GAMEOVER")
                gameOverFunc()
                gameOverAlert()
                //GAME OVER, player is out of tries
            }
        } else {  //esli otvetil verno ///OTVETIL PRAVILNO
            ///DOBAVIT OCHKI vnutri
            goToTheNextQuestion()
            playSound("RIGHT")
        }
    }
    
    ///////////////// NEXT QUESTION //////////////// NEXT QUESTION//////////////
    func goToTheNextQuestion() {
        let ifWeCanGoToTheNextQuestion = CURRENTQUESTIONINDEX + 1
        if ifWeCanGoToTheNextQuestion > fighters.count-1 {
            ///FIX
            wholeGameIsPathedBy()
        } else { //continue playing
            
            CURRENTQUESTIONINDEX += 1
            
            
        }
    }
    
    ////////////////// MY SHUFFLE FUNC ///////////////////////
    ///poluchit massiv sluchainih otvetov
    func getRandomAnswers(howmany howmany: Int) -> [String] {
        var result = [String]()
        var randomFighterForAnswersList: Fighter!
        for _ in 1...howmany {
            let rand = Int(arc4random_uniform(UInt32(fighters.count)))
            randomFighterForAnswersList = self.fighters[rand]
            
            ///esli imya sluchainogo sovpadaet s nashim tekushim v igre ili takoi uzhe dobavlen v spisok otvetov
            while randomFighterForAnswersList.name == self.currentFighter.name || result.contains({ $0 == randomFighterForAnswersList.name }) {
                let rand = arc4random_uniform(UInt32(fighters.count))
                randomFighterForAnswersList = self.fighters[Int(rand)]
            }
            result.append(randomFighterForAnswersList.name)
        }
        self.currentAnswerListData = result
        return result
    }
    
    ///generirovat indeks pravilnogo otveta
    func generateRightAnswer() -> Int {
        let rand = Int(arc4random_uniform(UInt32(self.answerListCount)))
        self.currentAnswerListData[rand] = self.currentFighter.name
        self.currentRightAnswerIndex = rand
        return rand
    }
    
    
    ////GAME OVER ALERT HERE /////////////
    func gameOverAlert() {
        let notifController = UIAlertController(title: "GAME OVER", message: "The game is over. Try more", preferredStyle: .Alert)
        let buttonOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
        notifController.addAction(buttonOk)
        qVController.presentViewController(notifController, animated: true, completion: {
            
            ///RESTART GAME
            self.restartGame()
        })
        
    }
    
    func wholeGameIsPathedBy() {
        playSound("ACHIEVMENT")
        let notifController = UIAlertController(title: "Congratulations!", message: "All game done...", preferredStyle: .Alert)
        let buttonOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
        notifController.addAction(buttonOk)
        qVController.presentViewController(notifController, animated: true, completion: nil)
        //GAME OVER ALERT
    }
    
    func playSound(soundName: String) {
        
        switch soundName {
        case "RIGHT":
            AudioServicesPlaySystemSound(1407)
            break
        case "WRONG":
            AudioServicesPlaySystemSound(1053)
            break
        case "GAMEOVER":
            AudioServicesPlaySystemSound(1006)
            break
        case "ACHIEVMENT":
            AudioServicesPlaySystemSound(1383)
            break
        case "SCROLLING": ///unused
            AudioServicesPlaySystemSound(1419)
            break
        default:
            break
            
        }
        
    }
    
    
    func restartGame() {
        
        CURRENTQUESTIONINDEX = 0
        self.currentFighter = self.fighters[0]
        //self.testLabel.text = score.description
        self.currentAnswerListData = self.getRandomAnswers(howmany: answerListCount)
        self.currentRightAnswerIndex = generateRightAnswer()
        self.testLabel.text = currentFighter.image
        self.triesLeft = 3
        qVController.resetDots()
        qVController.reloadPickerView()
        

    }
    
    
    
    
}


/// RIGHT 1394 1407 1430 1473 1440       WRONG 1053 1006

/// click 1057    1103    1130

/// 1128 1129 trnasition from to sound

/// 1429 picker scroll

/// 1335 1368 1383 achiev


// 1052 1431 1433 right





