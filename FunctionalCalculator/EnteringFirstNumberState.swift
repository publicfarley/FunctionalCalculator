//
//  EnteringFirstNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation

struct EnteringFirstNumberState: CalculatorState {
    let displayValue: String

    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
    
        let enteredNumber = try toInt(numberAsString)

        guard !(displayValue == "0" && enteredNumber == 0) else {
            return self
        }
        
        let numberToDisplay = (displayValue == "0") ? numberAsString : (displayValue + numberAsString)
        
        return EnteringFirstNumberState(displayValue: numberToDisplay)
    }
    
    
    func handleBinaryOperationEvent(operationName: String) throws -> CalculatorState {
        
        let binaryOperation = try binaryIntOperationFor(operationName)

        let firstNumber = try toInt(displayValue)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryOperation,
            displayValue: displayValue)
 
    }
    
    
    func handleUnaryOperationEvent(operationName: String) throws -> CalculatorState {
        
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let currentValue = try toInt(displayValue)
        
        let unaryOperationResult = String(unaryOperation(currentValue))
        
        return EnteringFirstNumberState(displayValue: unaryOperationResult)
    }
    
    
    func handleClearEvent() -> CalculatorState {
        return initialCalculatorState
    }
    
}

