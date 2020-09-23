//
//  ViewController.swift
//  NattyLog
//
//  Created by yonghoon.kwon on 01/11/2019.
//  Copyright (c) 2019 SK Telecom Co., Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import NattyLog

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var logLevelStepper: UIStepper!
    @IBOutlet private weak var logLevelLabel: UILabel!
    @IBOutlet private weak var descriptionLevelStepper: UIStepper!
    @IBOutlet private weak var descriptionLevelLabel: UILabel!
    @IBOutlet private weak var personaSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var prefixTextField: UITextField!
    @IBOutlet private weak var logTextField: UITextField!
    @IBOutlet private weak var logOutputTextView: UITextView!
    @IBOutlet private weak var outputMethodSegmentedControl: UISegmentedControl!
    
    // MARK: Override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Natty.delegate = self
        
        logTextField.delegate = self
        
        logLevelLabel.text = log.configuration.minLogLevel.name
        logLevelStepper.value = Double(LogLevelBound.lower(level: (log.configuration.minLogLevel)).value)
        
        descriptionLevelLabel.text = log.configuration.maxDescriptionLevel.name
        descriptionLevelStepper.value = Double(LogLevelBound.upper(level: log.configuration.maxDescriptionLevel).value)
        
        personaSegmentedControl.selectedSegmentIndex = log.configuration.showPersona ? 0 : 1
        
        switch log.configuration.outputMethod {
        case .nslog:
            outputMethodSegmentedControl.selectedSegmentIndex = 0
        case .print:
            outputMethodSegmentedControl.selectedSegmentIndex = 1
        case .custom:
            outputMethodSegmentedControl.selectedSegmentIndex = 2
        }
    }
}

// MARK: - IBAction

extension ViewController {
    @IBAction private func logLevelStepperDidChange(_ stepper: UIStepper) {
        let logLevelValue = Int(stepper.value)
        guard let logLevel = LogLevelBound.lowerLevel(value: logLevelValue) else { return }
        
        log.configuration.minLogLevel = logLevel
        
        logLevelLabel.text = logLevel.name
    }
    
    @IBAction private func descriptionStepperDidChange(_ stepper: UIStepper) {
        let descriptionLevelValue = Int(stepper.value)
        guard let logDescriptionLevel = LogLevelBound.upperLevel(value: descriptionLevelValue) else { return }
        
        log.configuration.maxDescriptionLevel = logDescriptionLevel
        
        descriptionLevelLabel.text = logDescriptionLevel.name
    }
    
    @IBAction private func personaSegmenetedControlDidChange(_ segmentedControl: UISegmentedControl) {
        log.configuration.showPersona = segmentedControl.selectedSegmentIndex == 0 ? true : false
    }
    
    @IBAction private func prefixConfirmButtonClick(_ button: UIButton) {
        log.configuration.prefix = prefixTextField.text
    }
    
    @IBAction private func outputMethodSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            log.configuration.outputMethod = .nslog
        case 1:
            log.configuration.outputMethod = .print
        case 2:
            log.configuration.outputMethod = .custom(closure: { (message) in
                print("Print: " + (message ?? "nil"))
                NSLog("NSLog: " + (message ?? "nil"))
            })
        default:
            log.configuration.outputMethod = .custom(closure: { (message) in
                return
            })
        }
    }
    
    @IBAction private func debugButtonClick(_ button: UIButton) {
        log.debug(logTextField.text) { [weak self] (result) in
            // If you want to send(or save) log message, you can use this closure
            // Also, You can skip this closure
            switch result {
            case .success(let message):
                self?.appendLogToTextView(message: message)
            default:
                break
            }
        }
    }
    
    @IBAction private func infoButtonClick(_ button: UIButton) {
        log.info(logTextField.text) { [weak self] (result) in
            // If you want to send(or save) log message, you can use this closure
            // Also, You can skip this closure
            switch result {
            case .success(let message):
                self?.appendLogToTextView(message: message)
            default:
                break
            }
        }
    }
    
    @IBAction private func warningButtonClick(_ button: UIButton) {
        log.warning(logTextField.text) { [weak self] (result) in
            // If you want to send(or save) log message, you can use this closure
            // Also, You can skip this closure
            
            switch result {
            case .success(let message):
                self?.appendLogToTextView(message: message)
            default:
                break
            }
        }
    }
    
    @IBAction private func errorButtonClick(_ button: UIButton) {
        log.error(logTextField.text) { [weak self] (result) in
            // If you want to send(or save) log message, you can use this closure
            // Also, You can skip this closure
            
            switch result {
            case .success(let message):
                self?.appendLogToTextView(message: message)
            default:
                break
            }
        }
    }
}

// MARK: - Business Logic

private extension ViewController {
    func appendLogToTextView(message: String?) {
        guard let logMessage = message else { return }
        
        logOutputTextView.text.append(contentsOf: "\(logMessage)\n")
        let bottomRange = NSMakeRange(logOutputTextView.text.count - 1, 1)
        logOutputTextView.scrollRangeToVisible(bottomRange)
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - NattyDelegate

extension ViewController: NattyDelegate {
    func nattyShouldDelegate(logMessage: String?, logLevel: LogLevel) -> Bool {
        guard logLevel != .debug else { return false }
        
        print("delegated: \(logMessage ?? "none")")
        return true
    }
}
