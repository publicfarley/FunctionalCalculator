//
//  ReadyToEnterSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-17.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation

struct ReadyToEnterSecondNumberState: CalculatorState {
    let firstNumber: Int
    let binaryIntOperation: BinaryIntOperation
    let displayValue: String
    
    
    
    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
        
        let secondNumber = try toInt(numberAsString)
        
        guard !(displayValue == "0" && secondNumber == 0) else {
            return self
        }
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            secondNumber: secondNumber,
            binaryIntOperation: binaryIntOperation,
            displayValue: numberAsString)
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
        
        let unaryOperationResult = unaryOperation(firstNumber)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: unaryOperationResult,
            binaryIntOperation: binaryIntOperation,
            displayValue:  String(unaryOperationResult))
        
    }
    
}