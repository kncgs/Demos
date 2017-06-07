//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// 1.

func productExceptSelf(nums: [Int]) -> [Int] {
    var result = nums
    
    for i in 1..<nums.count {
        result[i] = result[i-1] * nums[i-1]
    }
    var temp = 1
    for i in stride(from: nums.count-1, to: 0, by: -1) {
        result[i] *= temp
        temp *= nums[i]
    }
    
    result[0] = nums.dropFirst().reduce(1, *)
    return result
}

productExceptSelf(nums: [1, 2, 3, 4])


// 2.

func numberFirst(nums: [Int]) -> [Int] {
    let zeroCount = nums.filter { $0 == 0 }.count
    return nums
        .sorted(by: { $0 < $1 })
        .filter { $0 > 0 }
        + repeatElement(0, count: zeroCount)
}

numberFirst(nums:  [0, 1, 0, 3, 12])


// 3.
// 不会

// 4.

func `sqrt`(_ num: Int) -> Int {
    var start = 1, end = num
    while start + 1 < end {
        let mid = start + (end - start) / 2
        if mid * mid <= num {
            start = mid
        } else {
            end = mid
        }
    }
    return end * end <= num ? end : start
}

sqrt(0)
sqrt(9)


// 5. 

func `pow`(_ num: Int, _ time: Int) -> Int {
    return repeatElement(num, count: time).reduce(1, *)
}
pow(2, 3)
pow(3, 3)









