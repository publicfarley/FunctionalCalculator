//
//  CalculatorModel.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-02-03.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation


func divide(x: Int, _ y: Int) -> Int {
    return x/y
}

func add(x: Int, _ y: Int) -> Int {
    return x + y
}

func subtract(x: Int, _ y: Int) -> Int {
    return x - y
}

func multiply(x: Int, _ y: Int) -> Int {
    return x*y
}


func plusMinus(x: Int) -> Int {
    return -x
}

typealias BinaryIntOperation = (Int,Int) -> Int
typealias UnaryIntOperation = Int -> Int


