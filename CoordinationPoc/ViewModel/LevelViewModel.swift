//
//  LevelViewModel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 21/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

extension Timer {
    class func schedule(repeatInterval interval: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
}

import Foundation

class LevelViewModel : NSObject {
    
    fileprivate var coordinationTest: CoordinationTest
    
    fileprivate var currentLevel: CoordinationLevel {
        get {
            
            return coordinationTest.currentLevel!
        }
    }
    
    var shapeViewModel: ShapeViewModel?
    
    var handIdentifier : Dynamic<String>
    var currentTime: Dynamic<String>
    var path: Dynamic<String>
    
    var pathIsHidden: Dynamic<Bool>
    
    var newHand: Dynamic<Hand?>
    
    
    init(from test: CoordinationTest) {
        
        self.coordinationTest = test
        
        self.currentTime = Dynamic(LevelViewModel.timeRemainingPretty(for: test.currentLevel!))
        self.handIdentifier = Dynamic(LevelViewModel.handDisplay(for: test.currentLevel!))
        self.path = Dynamic(LevelViewModel.pathDisplay(for: test.currentLevel!))
        self.pathIsHidden = Dynamic(false)
        self.newHand = Dynamic(nil)
        
        self.shapeViewModel = ShapeViewModel(from: test.currentLevel!)
        
        super.init()
    }
    
    
    fileprivate func setup(from level: CoordinationLevel) {
        
        self.currentTime.value = LevelViewModel.timeRemainingPretty(for: level)
        self.handIdentifier.value = LevelViewModel.handDisplay(for: level)
        self.path.value = LevelViewModel.pathDisplay(for: level)
        self.shapeViewModel?.setup(with: level)
    }
    
    
    
    func reloadData() {
        
        self.setup(from: self.currentLevel)
    }
    
    
    func endLevel() {
        
        self.setLevelVisibility(false)
        self.coordinationTest.setLevelFinished()
        
        print("timer killed")
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    func loadNextLevel() {
        
        guard newHand.value != nil
            || self.currentLevel.hand == self.coordinationTest.nextHand() else {
                
                self.newHand.value = self.coordinationTest.nextHand()
                return
        }
        
        coordinationTest.goToNextLevel()
        self.reloadData()
        self.setLevelVisibility(true)
    }
    
    
    fileprivate func setLevelVisibility(_ visible: Bool) {
        
        self.pathIsHidden.value = !visible
    }
    
    
    func startLevel() {
        
        print("level started")
        self.startTimer()
    }
    
    
    
    var notificationToPresent: HorizontalNotification?
    
    
    
    fileprivate var timer: Timer?
    
    fileprivate func startTimer() {
        let interval: TimeInterval = 1.0/1000.0
        timer = Timer.schedule(repeatInterval: interval) { (timer) in
            self.currentLevel.timeElapsed += interval
            self.currentTime.value = LevelViewModel.timeRemainingPretty(for: self.currentLevel)
        }
    }
    
    // MARK: View events
    
    func viewDidAppear() {
        
        if self.pathIsHidden.value == false {
            
            self.startLevel()
        }
    }
    
    func viewWillAppear() {
        
        self.reloadData()
    }
    
    func pathDidShow() {
        
        self.startLevel()
    }
    
    func pathDidHide() {
        
        self.loadNextLevel()
    }
    
    func didChooseNextHandReady(_ answer: Bool) {
        
        self.loadNextLevel()
    }
    
    // MARK: String utils
    
    fileprivate static func timeFormatted(totalMillis: Int) -> String {
        
        let millis: Int = totalMillis % 1000 / 100
        let totalSeconds: Int = totalMillis / 1000
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        
        return String(format: "%02d:%02d.%d", minutes, seconds, millis)
    }
    
    fileprivate static func timeRemainingPretty(for level: CoordinationLevel) -> String {
        
        return timeFormatted(totalMillis: Int(level.timeElapsed * 1000))
    }
    
    fileprivate static func handDisplay(for level: CoordinationLevel) -> String {
        
        switch(level.hand) {
            
        case .right:
            return "R"
        case .left:
            return "L"
        }
    }
    
    fileprivate static func pathDisplay(for level:CoordinationLevel) -> String {
        
        return level.path
    }
}
