//
//  CalculatorModel.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-02-03.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation

struct NonZeroInt {
    let number: Int
    
    init?(number: Int) {
        guard number != 0 else { return nil }
        
        self.number = number
    }
}


func divide(_ x: Int, _ y: NonZeroInt) -> Int {
    return x/y.number
}

func plusMinus(_ x: Int) -> Int {
    return -x
}

// add, subtract and multiply provided natively by +, -, and * respectively.










