//
//  FirstHandChoiceViewModel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 03/10/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import Foundation

class FirstHandChoiceViewModel : NSObject {
    
    var questionText: String
    
    var leftHandImageName: String
    var rightHandImageName: String
    
    init(question: String, leftHandImageName: String, rightHandImageName: String) {
        
        self.questionText = question
        self.leftHandImageName = leftHandImageName
        self.rightHandImageName = rightHandImageName
        
        super.init()
    }
}
