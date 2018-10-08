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

enum CoordinationLevelNotification {
    static let levelDidFinishNotification = "levelDidFinishNotification"
}

class CoordinationLevel : NSObject {
    
    enum Status: String {
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
                NotificationCenter.default.post(name: Notification.Name(rawValue: CoordinationLevelNotification.levelDidFinishNotification), object: self)
            default:
                break
            }
        }
    }
    
    init(withJson json: String, hand:Hand, id: Int, isPractice: Bool) {
        
        self.startPosition = (x: ShapeViewModel.rdm(), y:ShapeViewModel.rdm())
        self.currentPosition = startPosition
        self.endPosition = (x: ShapeViewModel.rdm(), y:ShapeViewModel.rdm())
        
        print("start: \(startPosition.x) \(startPosition.y) end: \(endPosition.x) \(endPosition.y)")
        
        self.isPractice = isPractice
        self.identifier = id
        self.path = "Path \(String(describing: id))"
        self.hand = hand
    }
}
