//
//  CoordinationLevel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 24/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

import Foundation

struct HorizontalNotification {
    
    var duration: Int
    var text: String
}

enum Hand {
    
    case right
    case left
}

class CoordinationLevel : NSObject {
    
    enum Status {
        case inactive
        case introducing
        case ongoing
        case finished
    }
    
    var beginTimestamp: Date?
    var endTimestamp: Date?
    
    var isPractice: Bool = false
    
    let startPosition: (x: Int, y: Int)
    var currentPosition: (x: Int, y: Int)
    let endPosition: (x: Int, y: Int)
    
    var identifier: Int!
    var hand: Hand
    var path: String
    
    var timeElapsed: TimeInterval = 0.0
    
    var introductionNotifications: [HorizontalNotification] = []
    
    var status: Status = .inactive {
        didSet {
            switch self.status {

            case .ongoing:
                self.beginTimestamp = Date()
            case .finished:
                self.endTimestamp = Date()
            default:
                break
            }
        }
    }
    
    init(withJson json: String, hand:Hand, id: Int) {
        
        self.startPosition = (x: ShapeViewModel.rdm(), y:ShapeViewModel.rdm())
        self.currentPosition = startPosition
        self.endPosition = (x: ShapeViewModel.rdm(), y:ShapeViewModel.rdm())
        
        self.path = "Path \(String(describing: id))"
        self.hand = hand
    }
}
