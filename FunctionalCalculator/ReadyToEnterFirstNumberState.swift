//
//  ReadyToEnterFirstNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-17.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation


struct ReadyToEnterFirstNumberState: CalculatorState {
    let displayValue: String
    
    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
        
        let firstNumber = try toInt(numberAsString)
        
        guard !(displayValue == "0" && firstNumber == 0) else {
            return self
        }
        
        return EnteringFirstNumberState(displayValue: String(firstNumber))

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

    
    
    
}

let initialCalculatorState = ReadyToEnterFirstNumberState(displayValue: "0")

extension CalculatorState {
    
    func handleAllClearEvent() -> CalculatorState {
        return initialCalculatorState
    }
    
}