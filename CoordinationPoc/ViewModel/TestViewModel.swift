//
//  TestViewModel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 24/09/2018.
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

class TestViewModel : NSObject {
    
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
    
    init(from test: CoordinationTest) {
        
        self.coordinationTest = test
        
        self.currentTime = Dynamic(TestViewModel.timeRemainingPretty(for: test.currentLevel!))
        self.handIdentifier = Dynamic(TestViewModel.handDisplay(for: test.currentLevel!))
        self.path = Dynamic(TestViewModel.pathDisplay(for: test.currentLevel!))
        self.pathIsHidden = Dynamic(false)
        
        self.shapeViewModel = ShapeViewModel(from: test.currentLevel!)
        
        super.init()
        
        self.startTimer()
    }
    
    func endLevel() {
        
        self.pathIsHidden.value = true
        
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func pathDidAppear() {
        
        self.startTimer()
    }
    
    func pathDidDisappear() {
        
        self.setupNextLevel()
    }
    
    fileprivate func setupNextLevel() {
        
        coordinationTest.setupNextLevel()
        
        self.currentTime.value = TestViewModel.timeRemainingPretty(for: currentLevel)
        self.handIdentifier.value = TestViewModel.handDisplay(for: currentLevel)
        self.path.value = TestViewModel.pathDisplay(for: currentLevel)
        self.pathIsHidden.value = false
        
        shapeViewModel?.setup(with: currentLevel)
    }
    
    var notificationToPresent: HorizontalNotification?
    
    fileprivate var timer: Timer?
    fileprivate func startTimer() {
        let interval: TimeInterval = 1.0/1000.0
        timer = Timer.schedule(repeatInterval: interval) { (timer) in
            self.currentLevel.timeElapsed += interval
            self.currentTime.value = TestViewModel.timeRemainingPretty(for: self.currentLevel)
        }
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
