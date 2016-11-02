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
    
    func handleNumberEntryEvent(_ numberAsString: String) -> CalculatorState {
        
        guard !(displayValue == "0" && numberAsString == "0") else {
            return self
        }
        
        return EnteringFirstNumberState(displayValue: numberAsString)

    }
    
    
    func handleBinaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        
        let binaryOperation = try binaryIntOperationFor(operationName)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: displayValue,
            binaryIntOperation: binaryOperation,
            displayValue: displayValue)
        
    }
    
    
    func handleUnaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = try unaryOperation(displayValue)
        
        return EnteringFirstNumberState(displayValue: String(unaryOperationResult))
    }

    
    
    
}

let initialCalculatorState = ReadyToEnterFirstNumberState(displayValue: "0")

extension CalculatorState {
    
    func handleAllClearEvent() -> CalculatorState {
        return initialCalculatorState
    }
    
}
