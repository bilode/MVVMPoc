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
    
    var currentLevelIndex: Int = 0
    
    override init() {
        super.init()
        
        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 0))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 1))
        levels.append(CoordinationLevel(withJson: "", hand: .left, id: 2))
        levels.append(CoordinationLevel(withJson: "", hand: .right, id: 3))
    }
    
    var currentLevel: CoordinationLevel? {
        get {
            guard currentLevelIndex < levels.count else {
                return nil
            }
            
            return levels[currentLevelIndex]
        }
    }
    
    func finishLevel() {
        
        guard let currentLevel = self.currentLevel else {
            return
        }
        
        currentLevel.status = .finished
    }
    
    func setupNextLevel() {
        
        guard currentLevelIndex + 1 < levels.count else {
            return
        }
        
        currentLevelIndex += 1
    }
}
