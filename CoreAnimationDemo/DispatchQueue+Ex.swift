//
//  DispatchQueue+Ex.swift
//  CoreAnimationDemo
//
//  Created by redtwowolf on 19/09/2017.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    public class func mainDelay(_ second: TimeInterval,
                                _ closure: @escaping () -> Void) {
        DispatchQueue.main.delay(second, closure)
    }
    
    public func delay(_ second: TimeInterval,
                      _ closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + .milliseconds(Int(1000 * second)),
                   execute: closure)
    }
}
