//
//  EnteringSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation

struct EnteringSecondNumberState: CalculatorState {
    let firstNumber: Int
    let secondNumber: Int
    let binaryIntOperation: BinaryIntOperation
    let displayValue: String
    
    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
        
        guard !(displayValue == "0" && numberAsString == "0") else {
            return self
        }

        let numberToDisplay = String(displayValue) + numberAsString
        let newSecondNumber = try toInt(numberToDisplay)

        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            secondNumber: newSecondNumber,
            binaryIntOperation: binaryIntOperation,
            displayValue: numberToDisplay)
    }
    
    
    func handleBinaryOperationEvent(operationName: String) throws -> CalculatorState {
        
        let evaluation = binaryIntOperation(firstNumber,secondNumber)

        let newBinaryOperation = try binaryIntOperationFor(operationName)
        
        
        return ReadyToEnterSecondNumberState(
            firstNumber: evaluation,
            binaryIntOperation: newBinaryOperation,
            displayValue: String(evaluation))
    }
    
    
    func handleUnaryOperationEvent(operationName: String) throws -> CalculatorState {
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = unaryOperation(secondNumber)
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            secondNumber: unaryOperationResult,
            binaryIntOperation: binaryIntOperation,
            displayValue: String(unaryOperationResult))
    }
    
    
    
    
    func handleEvaluateEvent() -> CalculatorState {
        
        let evaluation = binaryIntOperation(firstNumber,secondNumber)
        
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
