//
//  ReadyToEnterFirstNumberState.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-03-11.
//  Copyright © 2016 AppObject. All rights reserved.
//

import Foundation

struct ReadyToEnterFirstNumberState: CalculatorState {
    let display: String
    
    func handleNumberEvent(number: String) -> CalculatorState {
        
        guard !(display == "0" && number == "0") else {
            return self
        }
        
        return EnteringFirstNumberState(display: number)
    }
    
}

let initialCalculatorState = ReadyToEnterFirstNumberState(display: "0")

extension CalculatorState {

    func handleAllClearEvent() -> CalculatorState {
        return initialCalculatorState
    }

}
