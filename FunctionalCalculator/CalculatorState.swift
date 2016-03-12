//
//  CalculatorState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

protocol CalculatorState {
    var display: String {get}
    
    func handleNumberEvent(number: String) -> CalculatorState
    func handleBinaryOperationEvent(binaryOperation: BinaryIntOperation) -> CalculatorState
    func handleUnaryOperationEvent(unaryOperation: UnaryIntOperation) -> CalculatorState
    func handleEvaluateEvent() -> CalculatorState
    func handleClearEvent() -> CalculatorState
    func handleAllClearEvent() -> CalculatorState
}



extension CalculatorState {
    
    func handleNumberEvent(number: String) -> CalculatorState {
        return self
    }
    
    func handleBinaryOperationEvent(binaryOperation: BinaryIntOperation) -> CalculatorState {
        return self
    }
    
    func handleUnaryOperationEvent(unaryOperation: UnaryIntOperation) -> CalculatorState {
        return self
    }
    
    func handleEvaluateEvent() -> CalculatorState {
        return self
    }
    
    func handleClearEvent() -> CalculatorState {
        return self
    }
        
    // Mark: Utility functions
    func calculatorDisplayTextAsInt(displayText: String) -> Int {
        return Int(displayText) ?? 0
    }
    
}
