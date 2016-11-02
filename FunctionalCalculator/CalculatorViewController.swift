//
//  CalculatorViewControllerr.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-02-02.
//  Copyright © 2016 Manning Publications Co. All rights reserved.
//

import UIKit



class CalculatorViewController: UIViewController {
    
    
    // MARK: Properties
    var currentCalculatorState: CalculatorState = initialCalculatorState {
        didSet {
            render(currentCalculatorState)
        }
    }
    
    fileprivate func render(_ calculatorPresentableDisplay: CalculatorDisplayValuePresentable) {
        calculatorDisplay.text = calculatorPresentableDisplay.displayValue
    }
    
    
    // MARK: Outlets
    @IBOutlet weak var calculatorDisplay: UILabel! {
        didSet {
            calculatorDisplay.layer.borderWidth = 0.5
            
            calculatorDisplay.layer.borderColor =
                UIColor.darkGray.cgColor
        }
    }
    
    
    // MARK: Event handling methods
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        guard let enteredNumber = sender.title(for: UIControlState()) else {
            NSLog("Title not set")
            return
        }
        
        let newCalculatorState =
            currentCalculatorState
                .handleNumberEntryEvent(enteredNumber)
            
        currentCalculatorState =  newCalculatorState
    }
    
    
    
    @IBAction func binaryOperationButtonPressed(_ sender: UIButton) {
        
        guard let operationName = sender.title(for: UIControlState()) else {
            NSLog("Button title not set.")
            return
        }
        
        
        do {
            let newCalculatorState =
                try currentCalculatorState
                    .handleBinaryOperationEvent(operationName)
            
            currentCalculatorState =  newCalculatorState
        }
        catch CalculatorStateError
            .operationNotSupported(let invalidOperation) {
            
            presentErrorAlert(
                "Operation '\(invalidOperation)' is not supported.")
        
        }
        catch {
            presentErrorAlert(
                "Operation '\(operationName)' caused an unexpected exception.")
        }
        
        
    }
    
    
    
    @IBAction func unaryOperationButtonPressed(_ sender: UIButton) {
        
        guard let operationName = sender.title(for: UIControlState()) else {
            NSLog("Button title not set.")
            return
        }
        
        do {
            let newCalculatorState =
                try currentCalculatorState
                    .handleUnaryOperationEvent(operationName)
            
            currentCalculatorState =  newCalculatorState
        }
        catch CalculatorStateError
            .operationNotSupported(let invalidOperation) {
            
            presentErrorAlert(
                "Operation '\(invalidOperation)' is not supported.")
        
        }
        catch {
            presentErrorAlert(
                "Operation '\(operationName)' caused an unexpected exception: \(error)")
        }
    }
    
    
    
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        
        do {
            let newCalculatorState = try currentCalculatorState.handleEvaluateEvent()
        
            currentCalculatorState =  newCalculatorState
        }
        catch {
            presentErrorAlert(
                "Evaluation caused an unexpected exception: \(error)")
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        let newCalculatorState =  currentCalculatorState.handleClearEvent()
        
        currentCalculatorState =  newCalculatorState
    }
    
    
    
    @IBAction func allClearButtonPressed(_ sender: UIButton) {
        let newCalculatorState = currentCalculatorState.handleAllClearEvent()
        
        currentCalculatorState = newCalculatorState
    }
    
    
    // MARK: Private helper methods
    fileprivate func presentErrorAlert(_ message: String) {
        let alertController =
        UIAlertController(title:"Error",
            message: message,
            preferredStyle: .alert)
        
        let okButton =
        UIAlertAction(title: "OK",
            style: .default,
            handler: nil)
        
        alertController.addAction(okButton)
        
        present(alertController,
            animated: true,
            completion: nil)
    }
    
    
}
