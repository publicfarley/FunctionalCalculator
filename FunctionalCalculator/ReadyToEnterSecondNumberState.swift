//
//  ReadyToEnterSecondNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct ReadyToEnterSecondNumberState: CalculatorState {
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
            display: number)
    }
    
    
    func handleBinaryOperationEvent(binaryOperation: BinaryIntOperation) -> CalculatorState {
        
        return ReadyToEnterSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            display: display)
    }
    
    
    func handleUnaryOperationEvent(unaryOperation: UnaryIntOperation) -> CalculatorState {
        
        let displayedNumberAsInt = calculatorDisplayTextAsInt(display)
        
        let unaryOperationResult = String(unaryOperation(displayedNumberAsInt))
        
        return EnteringSecondNumberState(
            firstNumber: firstNumber,
            binaryIntOperation: binaryIntOperation,
            display: unaryOperationResult)
        
    }
    
}
