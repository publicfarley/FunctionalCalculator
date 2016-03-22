//
//  CalculatorViewControllerr.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-02-02.
//  Copyright © 2016 AppObject. All rights reserved.
//

import UIKit



class CalculatorViewController: UIViewController {
    
    
    // MARK: Properties
    var currentCalculatorState: CalculatorState = initialCalculatorState {
        didSet {
            render(currentCalculatorState)
        }
    }
    
    private func render(calculatorState: CalculatorState) {
        calculatorDisplay.text = calculatorState.displayValue
    }
    
    
    // MARK: Outlets
    @IBOutlet weak var calculatorDisplay: UILabel! {
        didSet {
            calculatorDisplay.layer.borderWidth = 0.5
            
            calculatorDisplay.layer.borderColor =
                UIColor.darkGrayColor().CGColor
        }
    }
    
    
    // MARK: Event handling methods
    @IBAction func numberButtonPressed(sender: UIButton) {
        
        guard let enteredNumber = sender.titleForState(.Normal) else {
            NSLog("Title not set")
            return
        }
        
        do {
            let newCalculatorState =
            try currentCalculatorState.handleNumberEntryEvent(enteredNumber)
            
            currentCalculatorState =  newCalculatorState
        }
        catch CalculatorStateError.NumberConversionError(
            let unconvertibleValue) {
                
                presentErrorAlert(
                    "Number button '\(unconvertibleValue)' could not be converted to an integer.")
                
        }
        catch {
            
            presentErrorAlert(
                "Number button '\(enteredNumber)' caused unexpected exception.")
            
        }
        
    }
    
    
    
    @IBAction func binaryOperationButtonPressed(sender: UIButton) {
        
        guard let buttonTitle = sender.titleForState(.Normal) else {
            NSLog("Button title not set.")
            return
        }
        
        
        do {
            let newCalculatorState =
            try currentCalculatorState.handleBinaryOperationEvent(buttonTitle)
            
            currentCalculatorState =  newCalculatorState
        }
        catch CalculatorStateError.OperationNotSupported(let operation) {
            presentErrorAlert(
                "Operation '\(operation)' is not supported.")
        }
        catch {
            presentErrorAlert(
                "Operation '\(buttonTitle)' caused an unexpected exception.")
        }
        
        
    }
    
    
    
    @IBAction func unaryOperationButtonPressed(sender: UIButton) {
        
        guard let buttonTitle = sender.titleForState(.Normal) else {
            NSLog("Button title not set.")
            return
        }
        
        do {
            let newCalculatorState =
            try currentCalculatorState.handleUnaryOperationEvent(buttonTitle)
            
            currentCalculatorState =  newCalculatorState
        }
        catch CalculatorStateError.OperationNotSupported(let operation) {
            presentErrorAlert(
                "Operation '\(operation)' is not supported.")
        }
        catch {
            presentErrorAlert(
                "Operation '\(buttonTitle)' caused an unexpected exception.")
        }
    }
    
    
    
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        
        let newCalculatorState = currentCalculatorState.handleEvaluateEvent()
        
        currentCalculatorState =  newCalculatorState
    }
    
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        let newCalculatorState =  currentCalculatorState.handleClearEvent()
        
        currentCalculatorState =  newCalculatorState
    }
    
    
    
    @IBAction func allClearButtonPressed(sender: UIButton) {
        let newCalculatorState = currentCalculatorState.handleAllClearEvent()
        
        currentCalculatorState = newCalculatorState
    }
    
    
    // MARK: Private helper methods
    private func presentErrorAlert(message: String) {
        let alertController =
        UIAlertController(title:"Error",
            message: message,
            preferredStyle: .Alert)
        
        let okButton =
        UIAlertAction(title: "OK",
            style: .Default,
            handler: nil)
        
        alertController.addAction(okButton)
        
        presentViewController(alertController,
            animated: true,
            completion: nil)
    }
    
    
}