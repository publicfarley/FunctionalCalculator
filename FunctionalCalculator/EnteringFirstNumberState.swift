//
//  EnteringFirstNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct EnteringFirstNumberState: CalculatorState {
    let display: String
    
    func handleNumberEvent(number: String) -> CalculatorState {
        guard !(display == "0" && number == "0") else {
            return self
        }
        
        return EnteringFirstNumberState(display: display + number)
    }
    
    func handleBinaryOperationEvent(binaryIntOperation: BinaryIntOperation) -> CalculatorState {
        let capturedFirstNumber = calculatorDisplayTextAsInt(display)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: capturedFirstNumber,
            binaryIntOperation: binaryIntOperation,
            display: display)
    }
    
    func handleUnaryOperationEvent(unaryOperation: UnaryIntOperation) -> CalculatorState {
        
        let displayedNumberAsInt = calculatorDisplayTextAsInt(display)
        
        let unaryOperationResult = String(unaryOperation(displayedNumberAsInt))
        
        return EnteringFirstNumberState(display: unaryOperationResult)
    }
    
    func handleClearEvent() -> CalculatorState {
        return initialCalculatorState
    }
    
}
