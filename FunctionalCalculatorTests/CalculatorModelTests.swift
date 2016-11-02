//
//  CalculatorModelTests.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-04-16.
//  Copyright © 2016 AppObject. All rights reserved.
//

import XCTest
@testable import FunctionalCalculator


class CalculatorModelTests: XCTestCase {
    
    func testNonZeroIntTypeisNil() {
        XCTAssertNil(NonZeroInt(number: 0))
    }
    
    func testNonZeroIntTypeRepresentsCorrectValue() {
        // A few representative test cases
        XCTAssertEqual(1, NonZeroInt(number: 1)?.number)

        XCTAssertEqual(-1, NonZeroInt(number: -1)?.number)

        XCTAssertEqual(NSIntegerMax, NonZeroInt(number: NSIntegerMax)?.number)
        
        XCTAssertNotEqual(0, NonZeroInt(number: 1)?.number)
    }
    
    func testDivideByNonZeroIntReturnsCorrectValue() {
        
        XCTAssertEqual(5,divide(25,NonZeroInt(number: 5)!))

        XCTAssertEqual(5,divide(10,NonZeroInt(number: 2)!))
        
        XCTAssertEqual(2,divide(2,NonZeroInt(number: 1)!))
        
    }

    
    func testPlusMinusPositiveIntIsNegative() {
        XCTAssertEqual(-5,plusMinus(5))
        XCTAssertEqual(-1,plusMinus(1))
        XCTAssertEqual(-25,plusMinus(25))
        
    }
    
    func testPlusMinusNegativeIntIsPositive() {
        XCTAssertEqual(5,plusMinus(-5))
        XCTAssertEqual(1,plusMinus(-1))
        XCTAssertEqual(25,plusMinus(-25))
    }

    func testPlusMinusZeroIsZero() {
        XCTAssertEqual(0,plusMinus(0))
    }
    
}
