//  CountDown.swift
//  Countdown
//
//  Created by redtwowolf on 18/09/2017.
//  Copyright © 2017 test. All rights reserved.
//

extension Int {
    var days: Int {
        return self / 86400
    }
    var hours: Int {
        return (self % 86400) / 3600
    }
    var minutes: Int {
        return (self % 3600) / 60
    }
    var seconds: Int {
        return (self % 3600) % 60
    }
    /// 123456789 -> 5天10小时33分46秒
    var dhms: String {
        return "\(days)天" + "\(hours)小时" + "\(minutes)分" + "\(seconds)秒"
    }
}


import Foundation
import Dispatch

class CountDown {
    
    static let `default` = CountDown()
    
    private var timer: DispatchSourceTimer?
    
    private init() { }
    
    /**
     start countdown
     
     seconds = end - now

     * parameter end:       截止时间戳。
     * parameter onMain:    跳至主线程
     * parameter touchZero: 当seconds <= 0时，cancel Timer，跳至主线程
     */
    func start(terminate: Int,
               onMain: @escaping (Int) -> Void,
               touchZero: @escaping () -> Void) {
        
        timer = DispatchSource.timer(terminate: terminate,
                                     onMain: onMain,
                                     touchZero: touchZero)
    }
    
    /// stop countdown, cancel timer
    func stop() {
        timer?.cancel()
    }
}

extension DispatchSource {
    
    public class func timer(terminate: Int,
                            onMain: @escaping (Int) -> Void,
                            touchZero: @escaping () -> Void) -> DispatchSourceTimer {
        
        let current = Int(Date().timeIntervalSince1970)
        var seconds = terminate - current
        
        let result = DispatchSource.makeTimerSource(queue: .global())
        result.scheduleRepeating(deadline: .now(),
                                 interval: .seconds(1),
                                 leeway: .microseconds(1))
        result.setEventHandler {
            seconds -= 1
            if seconds >= 0 {
                DispatchQueue.main.async { onMain(seconds) }
            } else {
                DispatchQueue.main.async(execute: touchZero)
            }
        }
        result.resume()
        return result
    }
}
