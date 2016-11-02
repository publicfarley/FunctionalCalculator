//
//  CalculatorState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import Foundation


protocol CalculatorDisplayValuePresentable {
    var displayValue: String { get }
}

protocol CalculatorState: CalculatorDisplayValuePresentable {
    
    func handleNumberEntryEvent(_ numberAsString: String) -> CalculatorState
    func handleBinaryOperationEvent(_ operationName: String) throws -> CalculatorState
    func handleUnaryOperationEvent(_ operationName: String) throws -> CalculatorState
    func handleEvaluateEvent() throws -> CalculatorState
    func handleClearEvent() -> CalculatorState
    func handleAllClearEvent() -> CalculatorState
    
}



enum CalculatorStateError: Error {
    case operationNotSupported(unsupportedOperation: String)
    case undefinedResultError(reason: String)
}


// MARK: CalculatorState Default Function Implementations
extension CalculatorState {
        
    func handleNumberEntryEvent(_ numberAsString: String) -> CalculatorState {
        return self
    }
    
    func handleBinaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        return self
    }
    
    func handleUnaryOperationEvent(_ operationName: String) throws -> CalculatorState {
        return self
    }
    
    func handleEvaluateEvent() throws -> CalculatorState {
        return self
    }
    
    func handleClearEvent() -> CalculatorState {
        return self
    }
}



// MARK: Binary Opeartion Handlers
let addIntegersHandler = binaryOperationHandler(
    +,
    parameter1Convertor: stringToInt,
    parameter2Convertor: stringToInt)


let divideIntegersHandler = binaryOperationHandler(
    divide,
    parameter1Convertor: stringToInt,
    parameter2Convertor: stringToNonZeroInt)


let subtractIntegersHandler = binaryOperationHandler(
    -,
    parameter1Convertor: stringToInt,
    parameter2Convertor: stringToInt)


let multiplyIntegersHandler = binaryOperationHandler(
    *,
    parameter1Convertor: stringToInt,
    parameter2Convertor: stringToInt)


// MARK: Unary Operation Handlers
let plusMinusIntegersHandler = unaryOperationHandler(plusMinus,parameterConvertor: stringToInt)


// MARK: Operation Maps
private let binaryOperations =
    ["+": addIntegersHandler,
     "/": divideIntegersHandler,
     "*": multiplyIntegersHandler,
     "-": subtractIntegersHandler]

private let unaryOperations = ["+/-": plusMinusIntegersHandler]

typealias BinaryStringToIntOperation = (String,String) throws -> Int
typealias UnaryStringToIntOperation = (String) throws -> Int


// MARK: CalculatorState Utility Functions
extension CalculatorState {
    
    func binaryIntOperationFor(_ operationName: String) throws -> BinaryStringToIntOperation {
        
        guard let binaryOperation = binaryOperations[operationName] else {
            throw CalculatorStateError.operationNotSupported(unsupportedOperation: operationName)
        }
        
        return binaryOperation
    }
    

    
    func unaryIntOperationFor(_ operationName: String) throws -> UnaryStringToIntOperation {

        guard let unaryOperation = unaryOperations[operationName] else {
            throw CalculatorStateError.operationNotSupported(unsupportedOperation: operationName)
        }
        
        return unaryOperation
    }
    
    

    
}



