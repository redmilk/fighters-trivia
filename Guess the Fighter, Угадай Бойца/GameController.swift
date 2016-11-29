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

var theGameController: GameController!

class GameController {
    private var fighters: [Fighter] = [Fighter]()
    var currentFighter: Fighter!
    
    var triesLeft: Int = 3
    var answerListCount: Int!
    var currentAnswerListData: [String]!
    var currentRightAnswerIndex: Int!
    var score: Int = 0
    var highscore: Int = 0
    var testLabel: UILabel!
    var scoreLabel: UILabel!
    var soundMute: Bool!
    var gameIsOver: Bool = false
    var isItFirstQuestion: Bool!
    var skipFighter: Bool!
    init(debugLabel: UILabel, scoreLabel: UILabel) {
        
        self.skipFighter = false
        self.isItFirstQuestion = true

        /// Sound on / off
        self.soundMute = false
        self.testLabel = debugLabel
        self.scoreLabel = scoreLabel
        CURRENTQUESTIONINDEX = 0
        
        self.fighters = [Fighter(name: "Manny Paquiao", image: "pac1"),
         Fighter(name: "Mike Tyson", image: "tyson1"),
         Fighter(name: "Jon Jones", image: "jones1"),
         Fighter(name: "Conor McGregor", image: "conor1"),
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
         Fighter(name: "Mike Zambidis", image: "zambidis1"),  ]
        
        /*self.fighters = [Fighter(name: "Lion King", image: "lionking"),
                         Fighter(name: "Ice Age", image: "iceage"),
                         Fighter(name: "Duck's Stories", image: "duckstory"),
                         Fighter(name: "Cars", image: "cars"),
                         Fighter(name: "Finding Nemo", image: "findingnemo"),
                         Fighter(name: "Toystory", image: "toystory"),
                         Fighter(name: "Pinoccio", image: "pinoccio"),] */
        ///esli ukazano bolshe chem nuzhno to beskonechniy cikl
        self.answerListCount = 10 //
        
        self.fighters = self.fighters.shuffle()
        
        
        self.currentFighter = self.fighters[0]
        self.scoreLabel.text = score.description
        self.currentAnswerListData = self.getRandomAnswers(howmany: answerListCount)
        self.currentRightAnswerIndex = generateRightAnswer()
        //qVController.pickerSelectMiddleOption()
    }
    
    ///VSE ZAVYAZANO NA INDEKSE, KOGDA EGO MENYAEM ON UPRAVLYAET IZMENENIEM OSTALNOGO
    ///kogda menyaem indeks tekushego voprosa, menyaetsya currentFighter na sootv.
    var CURRENTQUESTIONINDEX: Int {
        
        didSet {
           
            
            /// chtob dva raza podryad ne srabativala animaciya smeni kartinki pri restarte
            if self.gameIsOver == true {
                return
            }
            
            if CURRENTQUESTIONINDEX > self.fighters.count {
                return
            }
            
            if self.isItFirstQuestion == true {
                self.isItFirstQuestion = false
            }
            
            self.currentFighter = self.fighters[CURRENTQUESTIONINDEX]
            qVController.pickerSelectMiddleOption()
            //SHOW SCORE FUNC -->
            self.scoreLabel.text = self.score.description
            self.currentAnswerListData = getRandomAnswers(howmany: self.answerListCount)
            self.currentRightAnswerIndex = self.generateRightAnswer()
            qVController.reloadPickerView()
            
            
            /// esli propustit boica (polzovatel oshibsya, sgorela popitka)
            if self.skipFighter == false {
                qVController.congratStripSetState("OPEN")
                qVController.answerButtonSetState("CLOSE")
                let triggerTime = (Int64(NSEC_PER_SEC) * Int64(2))
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    qVController.pickerSelectMiddleOption()
                    
                    qVController.congratStripSetState("CLOSE")
                    qVController.answerButtonSetState("OPEN")
                    qVController.setNewImage(self.fighters[self.CURRENTQUESTIONINDEX].image)
                    self.testLabel.text = self.currentAnswerListData[self.answerListCount/2]
                    self.score += 1 /// SCORE

                })
            } else {
                qVController.setNewImage(self.fighters[self.CURRENTQUESTIONINDEX].image)
                self.testLabel.text = self.currentAnswerListData[self.answerListCount/2]
            }
            
            if self.skipFighter == true {
                self.skipFighter = false
            }
        }
    }
    
    
    //////////////////////////////// RIGHT OR WRONG /////////////////////////////////
    
    func checkRightOrWrong(answer answer: String, changeXToDotFunc: ( ) -> (Void), gameOverFunc: ( ) -> (Void)) {
        let result = currentFighter.name == answer
        if result == false {  //esli dopustil oshibku
            qVController.backGroundColorChangeAnimationOnAnswer("WRONG")
            playSound("WRONG")
            if self.triesLeft - 1 >= 0 {
                self.triesLeft -= 1
                changeXToDotFunc()
                self.skipFighter = true
                self.CURRENTQUESTIONINDEX += 1
            }
            if self.triesLeft <= 0 {
                playSound("GAMEOVER")
                self.checkIfHighScore(self.score)
                gameIsOver = true
                gameOverFunc() ///EMPTY
                qVController.doSegueWithIdentifier("showGameOver")
                //GAME OVER, player is out of tries
            }
        } else {  //esli otvetil verno ///OTVETIL PRAVILNO
            ///DOBAVIT OCHKI vnutri
            if gameIsOver == false {
                goToTheNextQuestion()
            }
            playSound("RIGHT")
        }
    }
    
    ///////////////// NEXT QUESTION //////////////// NEXT QUESTION////////////// GAME DONE
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
        
        ///OTKLYUCHAEM PERVIY I POSLEDNIY VARIANTI K VIBORU
        
        var rand = 0
        repeat {
            rand = Int(arc4random_uniform(UInt32(self.answerListCount)))
        } while (rand == answerListCount - 1 || rand == 0)

        self.currentAnswerListData[rand] = self.currentFighter.name
        self.currentRightAnswerIndex = rand
        return rand
    }
    
    
    
    ///     GAME DONE
    func wholeGameIsPathedBy() {
        self.gameIsOver = true
        playSound("GAMEDONE")
        qVController.doSegueWithIdentifier("showGameDone")
    }
    
    func playSound(soundName: String) {
        if self.soundMute == true {
            return
        }
        switch soundName {
        case "RIGHT":
            AudioServicesPlaySystemSound(1394)
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
        case "SCROLL":
            AudioServicesPlaySystemSound(1121) //1222
            break
        case "GAMEDONE":
            AudioServicesPlaySystemSound(1332)
            break
        case "CHANGEIMAGE":
            AudioServicesPlaySystemSound(1129)
            break
        case "CLICK":
            AudioServicesPlaySystemSound(1130)
        default:
            break
        }
    }
    
    func restartGame() {
        self.isItFirstQuestion = true
        CURRENTQUESTIONINDEX = 0
        self.fighters = self.fighters.shuffle()
        self.currentFighter = self.fighters[0]
        self.currentAnswerListData = self.getRandomAnswers(howmany: answerListCount)
        self.currentRightAnswerIndex = generateRightAnswer()
        self.testLabel.text = currentFighter.image
        self.triesLeft = 3
        self.score = 1
        self.gameIsOver = false
        qVController.resetDots()
        qVController.reloadPickerView()
    }
    
    func checkIfHighScore(yourScore: Int) -> Bool {
        var r: Bool = false
        if yourScore > self.highscore {
            self.highscore = yourScore
            print("NEW HIGHSCORE")
            r = true
        }
        if yourScore == self.highscore {
            /// Uteshit igroka potomu chto emu ne hvatilo vsego 1 ochka do highscore ::)
        }
        return r
    }
    
}


//NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(seconds), target: self, selector: selector, userInfo: nil, repeats: false)



/// RIGHT 1394 (1407) 1430 1473 1440       WRONG 1053 1006

/// click 1057    1103    1130

/// 1128        1129 trnasition from to sound 1109 1018 1303

/// 1429 picker scroll

/// 1335 1368 1383 achiev 1034 1035

/// game done 1332
// 1052 1431 1433 right





