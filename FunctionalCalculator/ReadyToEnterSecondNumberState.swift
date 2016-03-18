//
//  ReadyToEnterSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-17.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct ReadyToEnterSecondNumberState: CalculatorState {
    let firstNumber: Int
    let binaryIntOperation: BinaryIntOperation
    let displayValue: Int
    
    
    
    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
        
        let number = try toInt(numberAsString)
        
        guard !(displayValue == 0 && number == 0) else {
            return self
        }
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            displayValue: number)
    }
    
    
    func handleBinaryOperationEvent(operationName: String) throws -> CalculatorState {
        
        let operation = try binaryIntOperationFor(operationName)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: operation,
            displayValue: displayValue)
    }
    
    
    func handleUnaryOperationEvent(operationName: String) throws -> CalculatorState {
        
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = unaryOperation(displayValue)
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            displayValue: unaryOperationResult)
        
    }
    
}