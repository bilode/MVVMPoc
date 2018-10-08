//
//  LevelViewModel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 24/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import Foundation

class TestViewModel : NSObject {
    
    var coordinationTest : CoordinationTest
    
    var firstHandChoiceIsReady: Dynamic<Bool>
    var levelsAreReady: Dynamic<Bool>
    var dataValidationChoiceIsReady: Dynamic<Bool>
    var surveyIsReady: Dynamic<Bool>
    
    var testCompleted: Bool = false
    
    var levelViewModel: LevelViewModel?
    
    init(from test: CoordinationTest) {
        
        self.coordinationTest = test
        
        self.levelViewModel = LevelViewModel(from: test)
        
        self.firstHandChoiceIsReady = Dynamic(false)
        self.levelsAreReady = Dynamic(false)
        self.dataValidationChoiceIsReady = Dynamic(false)
        self.surveyIsReady = Dynamic(false)
        
        super.init()
    }
    
    func setFirstHand(_ hand: Hand) {
        
        self.coordinationTest.orderLevels(withFirstHand: hand)
        startNextStep()
    }
    
    func startNextStep() {
        
        let steps = [firstHandChoiceIsReady, levelsAreReady, dataValidationChoiceIsReady, surveyIsReady]
        
        let currentStep = steps.index(where: { $0.value == true })
        
        if currentStep == nil {
            
            steps.first!.value = true
        } else if currentStep! + 1 < steps.count {
            
            steps[currentStep!].value = false
            steps[currentStep! + 1].value = true
            
        } else {
            
            self.testCompleted = true
        }
    }
}
