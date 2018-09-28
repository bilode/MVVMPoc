//
//  ShapeViewModel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 27/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import Foundation

class ShapeViewModel : NSObject {
    
    var coordinationLevel: CoordinationLevel
    
    var start: Dynamic<(x: Int, y: Int)>
    var current: Dynamic<(x: Int, y: Int)>
    var end: Dynamic<(x: Int, y: Int)>
    
    init(from level: CoordinationLevel) {
        
        self.coordinationLevel = level
        
        self.start = Dynamic(level.startPosition)
        self.current = Dynamic(level.currentPosition)
        self.end = Dynamic(level.endPosition)
        
        super.init()
    }
    
    func setup(with level:CoordinationLevel) {
        
        self.coordinationLevel = level
        
        self.start.value = level.startPosition
        self.current.value = level.currentPosition
        self.end.value = level.endPosition
    }
    
    static func rdm() -> Int {
        return Int(arc4random_uniform(100))
    }
}
