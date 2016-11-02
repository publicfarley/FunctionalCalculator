//
//  OperationHandler.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-04-16.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation


enum OperationError: Error {
    case invalidInputError(invalidInput: String)
}


/**
 * `binaryOperationHandler` is a generic function that that returns functions that take Strings as input and return the output of the supplied binaryOperation.
 * 
 * For example, to obtain an Integer addition function that takes Strings as input, we would do the following:
 
 func stringToInt(x: String) -> Int? {
    return Int(x)
 }
 
 let addIntegersHandler = binaryOperationHandler(
        +,
        parameter1Convertor: stringToInt,
        parameter2Convertor: stringToInt)
 
 // And to use it:
 
 addIntegersHandler("2","3")
 // -> 5
 
 *
 *
 */
func binaryOperationHandler<InputParameter1,InputParameter2,Output>(
    _ binaryOperation: @escaping (InputParameter1,InputParameter2) -> Output,
    parameter1Convertor: @escaping (String) -> InputParameter1?,
    parameter2Convertor: @escaping (String) -> InputParameter2?)
    
    -> ((String,String) throws -> Output) {
        
        func handler(_ x: String, y: String) throws -> Output {
            
            guard let inputParameter1 = parameter1Convertor(x) else {
                throw OperationError.invalidInputError(invalidInput: x)
            }
            
            guard let inputParameter2 = parameter2Convertor(y) else {
                throw OperationError.invalidInputError(invalidInput: y)
            }
            
            return binaryOperation(inputParameter1,inputParameter2)
        }
        

        return handler
        
}



/**
 * `unaryOperationHandler` is a generic function that that returns functions that take Strings as input and return the output of the supplied unaryOperation.
 *
 * For example, to obtain an Integer plus/minus function that takes a String as input, we would do the following:
 
 func stringToInt(x: String) -> Int? {
    return Int(x)
 }
 
 func plusMinus(x: Int) -> Int {
    return -x
 }
 
 let plusMinusIntegersHandler = unaryOperationHandler(plusMinus,parameterConvertor: stringToInt)

 
 // And to use it:
 
 plusMinusIntegersHandler("-2")
 // -> 2
 
 *
 *
 */
func unaryOperationHandler<InputParameter,Output>(
    _ unaryOperation: @escaping (InputParameter) -> Output,
    parameterConvertor: @escaping (String) -> InputParameter?)
    
    -> ((String) throws -> Output) {
        
        
        func handler(_ x: String) throws -> Output {
            
            guard let inputParameter = parameterConvertor(x) else {
                throw OperationError.invalidInputError(invalidInput: x)
            }
            
            return unaryOperation(inputParameter)
        }
        
        return handler
}



