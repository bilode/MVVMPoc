//
//  TestViewModel.swift
//  CoordinationPoc
//
//  Created by Timothée Bilodeau on 21/09/2018.
//  Copyright © 2018 Timothée Bilodeau. All rights reserved.
//

//extension Timer {
//    class func schedule(repeatInterval interval: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
//        let fireDate = interval + CFAbsoluteTimeGetCurrent()
//        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
//        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
//        return timer
//    }
//}
//
//import Foundation
//
//class TestViewModel : NSObject {
//
//    fileprivate var level: CoordinationLevel
//
//    var handIdentifier : Dynamic<String>
//    var currentTime: Dynamic<String>
//    var path: Dynamic<String>
//
//    var pathIsHidden: Dynamic<Bool>
//
//    init(fromLevel level: CoordinationLevel) {
//
//        self.level = level
//
//        self.currentTime = Dynamic(TestViewModel.timeRemainingPretty(for: level))
//        self.handIdentifier = Dynamic(TestViewModel.handDisplay(for: level))
//        self.path = Dynamic(TestViewModel.pathDisplay(for: level))
//        self.pathIsHidden = Dynamic(false)
//
//        super.init()
//
//        self.startTimer()
//    }
//
//    func pathDidAppear() {
//
//
//    }
//
//    func pathDidDisappear() {
//
//
//    }
//
//    fileprivate func setup(withLevel level: CoordinationLevel) {
//
//        self.level = level
//
//        self.currentTime.value = TestViewModel.timeRemainingPretty(for: level)
//        self.handIdentifier.value = TestViewModel.handDisplay(for: level)
//        self.path.value = TestViewModel.pathDisplay(for: level)
//        self.pathIsHidden.value = false
//
//        self.startTimer()
//    }
//
//    var notificationToPresent: HorizontalNotification?
//
//    fileprivate var timer: Timer?
//    fileprivate func startTimer() {
//        let interval: TimeInterval = 1.0/1000.0
//        timer = Timer.schedule(repeatInterval: interval) { (timer) in
//            self.level.timeElapsed += interval
//            self.currentTime.value = TestViewModel.timeRemainingPretty(for: self.level)
//        }
//    }
//
//    // MARK: String utils
//
//    fileprivate static func timeFormatted(totalMillis: Int) -> String {
//
//        let millis: Int = totalMillis % 1000 / 100
//        let totalSeconds: Int = totalMillis / 1000
//
//        let seconds: Int = totalSeconds % 60
//        let minutes: Int = (totalSeconds / 60)
//
//        return String(format: "%02d:%02d.%d", minutes, seconds, millis)
//    }
//
//    fileprivate static func timeRemainingPretty(for level: CoordinationLevel) -> String {
//
//        return timeFormatted(totalMillis: Int(level.timeElapsed * 1000))
//    }
//
//    fileprivate static func handDisplay(for level: CoordinationLevel) -> String {
//
//        switch(level.hand) {
//
//        case .right:
//            return "R"
//        case .left:
//            return "L"
//        }
//    }
//
//    fileprivate static func pathDisplay(for level:CoordinationLevel) -> String {
//
//        return level.path
//    }
//}
