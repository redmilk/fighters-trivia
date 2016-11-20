//
//  GameController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/14/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import Foundation



class GameController {
    private var fighters: [Fighter] = [Fighter]()
    var currentFighter: Fighter!
    private var currentQuestionIndex: Int!
    private var triesLeft: Int!
    var answerListCount: Int!
    private var answerListData: [String]!
    
    init() {
        
        self.currentQuestionIndex = 0
        self.triesLeft = 3
        
        self.fighters = [Fighter(name: "Manny Paquiao", image: "pacman1"),
                    Fighter(name: "Mike Tyson", image: "tyson1"),
                    Fighter(name: "Jon Jones", image: "jones1"),
                    Fighter(name: "Conor McGregor", image: "conor1"),
                    Fighter(name: "Habib Nurmagamedov", image: "khabib1")
        ]
        
        self.currentFighter = self.fighters[0]
        self.answerListCount = 5
        
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
    
    
    ///dopustil oshibku
    func oneTryLost() {
        if self.triesLeft - 1 > 0 {
            self.triesLeft! -= 1
            /// dobavit krestit vmesto tochki
        } else {
            ///GAME OVER, player is out of tries
        }
    }
    
    ///proverit verno ili net
    func checkRightOrWrong(answer answer: String) -> Bool {
        let result = currentFighter.name == answer
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
            self.answerListData = getRandomAnswers(howmany: self.answerListCount)
        }
    }
    
    func getRandomAnswers(howmany howmany: Int) -> [String] {
        var result = [String]()
        var randomFighterForAnswersList: Fighter!
        for _ in 1...howmany {
            let rand = arc4random_uniform(UInt32(fighters.count))
            randomFighterForAnswersList = self.fighters[Int(rand)]
            
            ///esli imya sluchainogo sovpadaet s nashim tekushim v igre ili takoi uzhe dobavlen v spisok otvetov
            while randomFighterForAnswersList.name == self.currentFighter.name || result.contains({ $0 == randomFighterForAnswersList.name }) {
                let rand = arc4random_uniform(UInt32(fighters.count))
                randomFighterForAnswersList = self.fighters[Int(rand)]
            }
            result.append(randomFighterForAnswersList.name)
        }
        return result
    }
    
    }
}




