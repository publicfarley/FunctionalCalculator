//
//  CalculatorViewControllerr.swift
//  FunctionalCalculator
//
//  Created by Farley Caesar on 2016-02-02.
//  Copyright © 2016 AppObject. All rights reserved.
//

import UIKit



class CalculatorViewController: UIViewController {
    
    // MARK: Constants
    let binaryOperationsMap = ["+": add,"-": subtract,"*": multiply,"/": divide]
    let unaryOperationsMap = ["+/-": plusMinus]
    

    
    // MARK: Properties
    var currentCalculatorState: CalculatorState = initialCalculatorState
    
    // MARK: Outlets
    @IBOutlet weak var calculatorDisplay: UILabel!
    
    
    // MARK: ViewController Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalculatorDisplay()

        render(currentCalculatorState)
    }
    
    
    // MARK: Event handling methods
    @IBAction func numberButtonPressed(sender: UIButton) {
        
        guard let number = sender.titleForState(.Normal) else {
            NSLog("Title not set")
            return
        }
        
        let newCalculatorState = currentCalculatorState.handleNumberEvent(number)

        render(newCalculatorState)

        currentCalculatorState =  newCalculatorState
    }
    
    
    
    @IBAction func binaryOperationButtonPressed(sender: UIButton) {
        
        guard let buttonTitle = sender.titleForState(.Normal) else {
            NSLog("Button title not set.")
            return
        }
        
        guard let binaryOperation = binaryOperationsMap[buttonTitle] else {
            NSLog("Binary Operation '\(buttonTitle)' not supported.")
            return
        }
        
        let newCalculatorState =  currentCalculatorState.handleBinaryOperationEvent(binaryOperation)
        
        render(newCalculatorState)
        
        currentCalculatorState =  newCalculatorState
    }
    
    
    
    @IBAction func unaryOperationButtonPressed(sender: UIButton) {
        
        guard let buttonTitle = sender.titleForState(.Normal) else {
            NSLog("Button title not set.")
            return
        }
        
        guard let unaryOperation = unaryOperationsMap[buttonTitle] else {
            NSLog("Unary Operation '\(buttonTitle)' does not exist.")
            return
        }
        

        let newCalculatorState =  currentCalculatorState.handleUnaryOperationEvent(unaryOperation)
        
        render(newCalculatorState)
        
        currentCalculatorState =  newCalculatorState

    }
    
    
    
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        
        let newCalculatorState = currentCalculatorState.handleEvaluateEvent()
        
        render(newCalculatorState)
        
        currentCalculatorState =  newCalculatorState
        
    }
    
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        let newCalculatorState =  currentCalculatorState.handleClearEvent()
        
        render(newCalculatorState)
        
        currentCalculatorState =  newCalculatorState
        
    }
    
    
    
    @IBAction func allClearButtonPressed(sender: UIButton) {
        let newCalculatorState = currentCalculatorState.handleAllClearEvent()
        
        render(newCalculatorState)
        
        currentCalculatorState = newCalculatorState
    }
    
    
    // MARK: Private helper methods
    private func render(calculatorState: CalculatorState) {
        calculatorDisplay.text = calculatorState.display
    }
    
    
    private func calculatorDisplayTextAsInt(displayText: String?) -> Int {
        return Int(displayText ?? "0") ?? 0
    }
    
    
    private func configureCalculatorDisplay() {
        calculatorDisplay.layer.borderWidth = 0.5
        calculatorDisplay.layer.borderColor = UIColor.darkGrayColor().CGColor
    }
    
    
}