//
//  EnteringSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct EnteringSecondNumberState: CalculatorState {
    let firstNumber: Int
    let binaryIntOperation: BinaryIntOperation
    let display: String
    
    func handleNumberEvent(number: String) -> CalculatorState {
        guard !(display == "0" && number == "0") else {
            return self
        }
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            display: display + number)
    }
    
    func handleBinaryOperationEvent(binaryOperation: BinaryIntOperation) -> CalculatorState {
        
        let secondNumber = calculatorDisplayTextAsInt(display)
        let evaluation = binaryOperation(firstNumber,secondNumber)
        
        return EvaluatedState(display: String(evaluation))
        
    }
    
    func handleUnaryOperationEvent(unaryOperation: UnaryIntOperation) -> CalculatorState {
        let displayedNumberAsInt = calculatorDisplayTextAsInt(display)
        
        let unaryOperationResult = String(unaryOperation(displayedNumberAsInt))
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            display: unaryOperationResult)
    }
    
    func handleEvaluateEvent() -> CalculatorState {
        
        let secondNumberAsInt = calculatorDisplayTextAsInt(display)
        let evaluation = binaryIntOperation(firstNumber,secondNumberAsInt)
        
        return EvaluatedState(display: String(evaluation))
    }
    
    func handleClearEvent() -> CalculatorState {
        
        return ReadyToEnterSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            display: "0")
        
    }
    
}
