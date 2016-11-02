//
//  ReadyToEnterSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-17.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation

struct ReadyToEnterSecondNumberState: CalculatorState {
    let firstNumber: String
    let binaryIntOperation: BinaryStringToIntOperation
    let displayValue: String
    
    
    
    func handleNumberEntryEvent(_ numberAsString: String) -> CalculatorState {
        
        guard !(displayValue == "0" && numberAsString == "0") else {
            return self
        }
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            secondNumber: numberAsString,
            binaryIntOperation: binaryIntOperation,
            displayValue: numberAsString)
    }
    
    
    func handleBinaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        
        let operation = try binaryIntOperationFor(operationName)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: operation,
            displayValue: displayValue)
    }
    
    
    func handleUnaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = try unaryOperation(firstNumber)
        
//        guard let unaryOperationResult = unaryOperation(firstNumber) else {
//            throw CalculatorStateError.UndefinedResultError(reason: "Could not perform \(operationName) on \(firstNumber)")
//        }
        
        return ReadyToEnterSecondNumberState(
            firstNumber: String(unaryOperationResult),
            binaryIntOperation: binaryIntOperation,
            displayValue:  String(unaryOperationResult))
        
    }
    
}
