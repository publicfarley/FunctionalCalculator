//
//  StringConversion.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-04-16.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

func stringToInt(_ x: String) -> Int? {
    return Int(x)
}

func stringToNonZeroInt(_ x: String) -> NonZeroInt? {
    guard let number = stringToInt(x) else { return nil }
    
    return NonZeroInt(number: number)
}



