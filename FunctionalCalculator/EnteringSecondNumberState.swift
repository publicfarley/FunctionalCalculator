//
//  EnteringSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation

struct EnteringSecondNumberState: CalculatorState {
    let firstNumber: String
    let secondNumber: String
    let binaryIntOperation: BinaryStringToIntOperation
    let displayValue: String
    
    func handleNumberEntryEvent(_ numberAsString: String) -> CalculatorState {
        
        guard !(displayValue == "0" && numberAsString == "0") else {
            return self
        }

        let numberToDisplay = displayValue == "0" ? numberAsString :  (displayValue + numberAsString)

        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            secondNumber: numberToDisplay,
            binaryIntOperation: binaryIntOperation,
            displayValue: numberToDisplay)
    }
    
    
    func handleBinaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        
        let newBinaryOperation = try binaryIntOperationFor(operationName)
        
        let evaluation = try binaryIntOperation(firstNumber,secondNumber)

//        guard let evaluation = binaryIntOperation(firstNumber,secondNumber) else {
//            throw CalculatorStateError.UndefinedResultError(reason: "Could not perform \(binaryIntOperation) on \(firstNumber),\(secondNumber)")
//        }
        
        
        return ReadyToEnterSecondNumberState(
            firstNumber: String(evaluation),
            binaryIntOperation: newBinaryOperation,
            displayValue: String(evaluation))
    }
    
    
    func handleUnaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = try unaryOperation(secondNumber)
        
//        guard let unaryOperationResult = unaryOperation(secondNumber) else {
//            throw CalculatorStateError.UndefinedResultError(reason: "Could not perform \(operationName) on \(secondNumber)")
//        }
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            secondNumber: String(unaryOperationResult),
            binaryIntOperation: binaryIntOperation,
            displayValue: String(unaryOperationResult))
    }
    
    
    
    
    func handleEvaluateEvent() throws -> CalculatorState {

        let evaluation = try binaryIntOperation(firstNumber,secondNumber)
//        guard let evaluation = binaryIntOperation(firstNumber,secondNumber) else {
//            throw CalculatorStateError.UndefinedResultError(reason: "Could not perform \(binaryIntOperation) on \(firstNumber),\(secondNumber)")
//        }
        
        return ReadyToEnterFirstNumberState(
            displayValue: String(evaluation))
    }
    
    
    
    func handleClearEvent() -> CalculatorState {
        
        return ReadyToEnterSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            displayValue: "0")
    }
    
}
