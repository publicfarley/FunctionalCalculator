//
//  EvaluatedState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

 struct EvaluatedState: CalculatorState {
     let displayValue: Int

     func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
     
         let number = try toInt(numberAsString)
         
         return EnteringFirstNumberState(displayValue: number)
     }
     
    func handleBinaryOperationEvent(operationName: String) throws -> CalculatorState {
        
        let binaryOperation = try binaryIntOperationFor(operationName)
        
        return ReadyToEnterSecondNumberState(
            firstNumber: displayValue,
            binaryIntOperation: binaryOperation,
            displayValue: displayValue)
    }

     func handleUnaryOperationEvent(operationName: String) throws -> CalculatorState {
         
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = unaryOperation(displayValue)
        
        return EnteringFirstNumberState(displayValue: unaryOperationResult)
     }
     

 }
