//
//  ReadyToEnterFirstNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct ReadyToEnterFirstNumberState: CalculatorState {
    let displayValue: Int
    
    func handleNumberEntryEvent(numberAsString: String) throws -> CalculatorState {
    
        let number = try toInt(numberAsString)
        
        guard !(displayValue == 0 && number == 0) else {
            return self
        }
        
        return EnteringFirstNumberState(displayValue: number)
    }
    
}

let initialCalculatorState = ReadyToEnterFirstNumberState(displayValue: 0)

extension CalculatorState {

    func handleAllClearEvent() -> CalculatorState {
        return initialCalculatorState
    }

}
