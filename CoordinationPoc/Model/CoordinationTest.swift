//
//  CoordinationTest.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 24/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import Foundation

class CoordinationTest : NSObject {

    var levels: [CoordinationLevel] = []
    var mobileDevice : [String: Any] = [:]
    var survey : [String: Any] = [:]
    var screen : [String: Any] = [:]
    
    var currentLevelIndex: Int = 0
    
    override init() {
        super.init()
        
        
        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 0, isPractice: true))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 1, isPractice: true))
//        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 2, isPractice: true))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 3, isPractice: false))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 6, isPractice: true))
//        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 3, isPractice: false))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 4, isPractice: false))
//        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 3, isPractice: true))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 0, isPractice: false))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 7, isPractice: true))
//        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 19, isPractice: false))
        
        self.orderLevels()
    }
    
    var areLevelsFinished : Bool {
        
        return false
    }
    
    var isSurveyFinished : Bool {
        
        return false
    }
    
    var currentLevel: CoordinationLevel? {
        get {
            guard currentLevelIndex < levels.count else {
                return nil
            }
            
            return levels[currentLevelIndex]
        }
    }
    
    func setLevelFinished() {
        
        guard let currentLevel = self.currentLevel else {
            return
        }
        
        currentLevel.status = .finished
    }
    
    func setLevelStarted() {
        
        guard let currentLevel = self.currentLevel else {
            return
        }
        
        currentLevel.status = .ongoing
    }
    
    func goToNextLevel() {
        
        guard currentLevelIndex + 1 < levels.count else {
                
                return
        }
        
        currentLevelIndex += 1
    }

    func isLastLevel() -> Bool {
        
        return currentLevelIndex + 1 >= levels.count
    }
    
    func nextHand() -> Hand? {
        
        guard !isLastLevel() else {
            return nil
        }
        
        return levels[currentLevelIndex + 1].hand
    }
    
    
    func orderLevels(withFirstHand hand: Hand? = .right) {
        
        self.levels = levels.sorted { (lhs, rhs) -> Bool in
            
            if lhs.hand == rhs.hand {
                if lhs.isPractice == rhs.isPractice {
                    return lhs.identifier <= rhs.identifier
                } else {
                    return lhs.isPractice
                }
            } else {
                return lhs.hand == hand
            }
        }
    }
}
