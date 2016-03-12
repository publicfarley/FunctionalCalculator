//
//  EvaluatedState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct EvaluatedState: CalculatorState {
    let display: String
    
    func handleNumberEvent(number: String) -> CalculatorState {
        return EnteringFirstNumberState(display: number)
    }
    
    func handleUnaryOperationEvent(unaryOperation: UnaryIntOperation) -> CalculatorState {
        let displayedNumberAsInt = calculatorDisplayTextAsInt(display)
        
        let unaryOperationResult = String(unaryOperation(displayedNumberAsInt))
        
        return EnteringFirstNumberState(display: unaryOperationResult)
    }
    
    func handleBinaryOperationEvent(binaryOperation: BinaryIntOperation) -> CalculatorState {
        
        let displayedNumberAsInt = calculatorDisplayTextAsInt(display)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: displayedNumberAsInt,
            binaryIntOperation: binaryOperation,
            display: display)
    }
}
