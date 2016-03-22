//
//  CalculatorState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation




protocol CalculatorState {

    var displayValue: String {get}
    
    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState
    func handleBinaryOperationEvent(operationName: String) throws -> CalculatorState
    func handleUnaryOperationEvent(operationName: String) throws -> CalculatorState
    func handleEvaluateEvent() -> CalculatorState
    func handleClearEvent() -> CalculatorState
    func handleAllClearEvent() -> CalculatorState
    
}

enum CalculatorStateError: ErrorType {
    case NumberConversionError(unconvertibleValue: String)
    case OperationNotSupported(unsupportedOperation: String)
}


// MARK: CalculatorState Default Function Implementations
extension CalculatorState {
        
    func handleNumberEntryEvent(numberAsString: String) -> CalculatorState {
        return self
    }
    
    func handleBinaryOperationEvent(operationName: String) -> CalculatorState {
        return self
    }
    
    func handleUnaryOperationEvent(operationName: String) -> CalculatorState {
        return self
    }
    
    func handleEvaluateEvent() -> CalculatorState {
        return self
    }
    
    func handleClearEvent() -> CalculatorState {
        return self
    }
}


// MARK: CalculatorState Utility Functions
extension CalculatorState {

    var binaryOperationsMap: [String: BinaryIntOperation] {
        return ["+": add,"-": subtract,"*": multiply,"/": divide]
    }
    
    var unaryOperationsMap: [String: UnaryIntOperation] {
        return ["+/-": plusMinus]
    }
    
    
    func binaryIntOperationFor(operationName: String) throws -> BinaryIntOperation {

        guard let binaryOperation = binaryOperationsMap[operationName] else {
            throw CalculatorStateError.OperationNotSupported(unsupportedOperation: operationName)
        }
        
        return binaryOperation
    }
    

    func unaryIntOperationFor(operationName: String) throws -> UnaryIntOperation {
        guard let unaryOperation = unaryOperationsMap[operationName] else {
            throw CalculatorStateError.OperationNotSupported(unsupportedOperation: operationName)
        }
        
        return unaryOperation
    }
    
    func toInt(stringValue: String) throws -> Int {
        
        guard let integerRepresentation = Int(stringValue) else {
            throw CalculatorStateError.NumberConversionError(unconvertibleValue: stringValue)
        }
        
        return integerRepresentation
    }
    
}



