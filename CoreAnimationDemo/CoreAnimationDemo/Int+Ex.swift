//
//  Int+Ex.swift
//  CoreAnimationDemo
//
//  Created by redtwowolf on 19/09/2017.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreGraphics.CGBase

extension Int {
    
    var toRadian: CGFloat {
        return CGFloat(Double(self) / 180 * .pi)
    }
    
}
