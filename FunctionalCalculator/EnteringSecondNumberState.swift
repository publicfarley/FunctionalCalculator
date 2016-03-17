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
     let displayValue: Int
     
     func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
     
         let number = try toInt(numberAsString)
         
         guard !(displayValue == 0 && number == 0) else {
             return self
         }
         
         let newDisplayValue = try toInt(String(displayValue)+numberAsString)
         
         return EnteringSecondNumberState(
             firstNumber: firstNumber,
             binaryIntOperation: binaryIntOperation,
             displayValue: newDisplayValue)
     }
     
    
     func handleBinaryOperationEvent(operationName: String) throws -> CalculatorState {

        let binaryOperation = try binaryIntOperationFor(operationName)

        let evaluation = binaryOperation(firstNumber,displayValue)
         
         return EvaluatedState(displayValue: evaluation)
         
     }
     
    
     func handleUnaryOperationEvent(operationName: String) throws -> CalculatorState {
         // let displayedNumberAsInt = calculatorDisplayTextAsInt(display)
         
         //let unaryOperationResult = String(unaryOperation(displayedNumberAsInt))
        let unaryOperation = try unaryIntOperationFor(operationName)
        
        let unaryOperationResult = unaryOperation(displayValue)
        
         return EnteringSecondNumberState(
             firstNumber: firstNumber,
             binaryIntOperation: binaryIntOperation,
             displayValue: unaryOperationResult)
     }
    
    
    
     
     func handleEvaluateEvent() -> CalculatorState {
         
         let evaluation = binaryIntOperation(firstNumber,displayValue)
         
         return EvaluatedState(displayValue: evaluation)
     }
     

    
    func handleClearEvent() -> CalculatorState {
         
         return ReadyToEnterSecondNumberState(
             firstNumber: firstNumber,
             binaryIntOperation: binaryIntOperation,
             displayValue: 0)
         
     }
     
 }
