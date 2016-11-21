//
//  GameController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/14/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import Foundation

//for debug window
import UIKit


class GameController {
    private var fighters: [Fighter] = [Fighter]()
    var currentFighter: Fighter!
    private var currentQuestionIndex: Int!
    
    var triesLeft: Int = 3
    var answerListCount: Int!
    var currentAnswerListData: [String]!
    var CurrentRightAnswerIndex: Int!
    
    var testLabel: UILabel!
    
    init(debugLabel: UILabel) {
        
        self.testLabel = debugLabel
        
        self.currentQuestionIndex = 0
        //self.triesLeft = 3
        
        self.fighters = [Fighter(name: "Manny Paquiao", image: "pacman1"),
                         Fighter(name: "Mike Tyson", image: "tyson1"),
                         Fighter(name: "Jon Jones", image: "jones1"),
                         Fighter(name: "Conor McGregor", image: "conor1"),
                         Fighter(name: "Habib Nurmagamedov", image: "khabib1"),
                         Fighter(name: "Buakaw Banchamek", image: "khabib1"),
                         Fighter(name: "Dzhabar Askerov", image: "khabib1"),
                         Fighter(name: "Roy Jones Jr", image: "khabib1"),
                         Fighter(name: "Vasiliy Lomachenko", image: "khabib1")]
        
        self.currentFighter = self.fighters[0]
        self.answerListCount = 8
        
        var result = [String]()
        var randomFighterForAnswersList: Fighter!
        
        for _ in 1...answerListCount {
            let rand = arc4random_uniform(UInt32(fighters.count))
            randomFighterForAnswersList = self.fighters[Int(rand)]
            
            ///esli imya sluchainogo sovpadaet s nashim tekushim v igre ili takoi uzhe dobavlen v spisok otvetov
            while randomFighterForAnswersList.name == currentFighter.name || result.contains({ $0 == randomFighterForAnswersList.name }) {
                let rand = arc4random_uniform(UInt32(fighters.count))
                randomFighterForAnswersList = self.fighters[Int(rand)]
            }
            result.append(randomFighterForAnswersList.name)
            
        }
        currentAnswerListData = result
        
        self.CurrentRightAnswerIndex = generateRightAnswer()

    }
    
    
    
    
    var CurrentQuestionIndex: Int = 0 {
        didSet {
            self.currentFighter = self.fighters[CurrentQuestionIndex]
        }
    }
    
    var FightersCount: Int {
        get {
            return fighters.count
        }
    }
    
    
    ///proverit verno ili net
    func checkRightOrWrong(answer answer: String, hideXfunc: ( ) -> (Void), gameOverFunc: ( ) -> (Void) ) -> Bool {
        let result = currentFighter.name == answer
        self.testLabel.text = self.triesLeft.description
        //self.testLabel.text = result.description
        if result == false {  //esli dopustil oshibku
            if self.triesLeft - 1 >= 0 {
                self.triesLeft -= 1
                hideXfunc()
                // dobavit krestik vmesto tochki
            }
            if self.triesLeft <= 0 {
                gameOverFunc()
                //GAME OVER, player is out of tries
                
            }
        } else {  //esli otvetil verno
            
        }
        return result
    }
    
    ///pereiti k sleduyushemu voprosu
    func goToTheNextQuestion() {
        let ifWeCanGoToTheNextQuestion = currentQuestionIndex + 1
        if ifWeCanGoToTheNextQuestion > fighters.count-1 {
            ///PLAYER PATHED WHOLE GAME
            print("That was the final question")
        } else {
            self.currentQuestionIndex! += 1
            self.currentAnswerListData = getRandomAnswers(howmany: self.answerListCount)
        }
    }
    
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
    
    ///
    func generateRightAnswer() -> Int {
        let rand = Int(arc4random_uniform(UInt32(self.answerListCount)))
        self.currentAnswerListData[rand] = self.currentFighter.name
        self.CurrentRightAnswerIndex = rand
        return rand
    }
    
}





