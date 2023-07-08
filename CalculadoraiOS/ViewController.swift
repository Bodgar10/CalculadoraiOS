//
//  ViewController.swift
//  CalculadoraiOS
//
//  Created by Bodgar Jair Espinosa Miranda on 27/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Operators: Int {
        case dot = 10
        case reset = 11
        case negative = 12
        case percentage = 13
        case division = 14
        case multiplication = 15
        case minus = 16
        case sum = 17
    }
    
    // MARK: - Outlets
    @IBOutlet weak var resultOperationLabel: UILabel!
    
    // MARK: - Variables
    
    var numberOnScreen = 0.0
    var previousNumber = 0.0
    
    /// Bool que ayuda a saber si el usuario ya le dio click a una operación
    var isClickingOperation = false
    var isResultShowed = false
    var currentOperation = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resultOperationLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    @IBAction func didTapNumberButton(_ sender: UIButton) {
        /// Añadiendo el numero que el usuario presionó a una constante llamada 'number'
        let number = sender.tag
        
        if isClickingOperation {
            isClickingOperation = false
            /// Almacenar dicho numero en una variable global llamada 'numberOnScreen'
            numberOnScreen = Double(number)
            /// Mostramos este numero en la pantalla
            self.resultOperationLabel.text = String(number)
        } else {
            if isResultShowed {
                resultOperationLabel.text = ""
            }
            guard let text = resultOperationLabel.text else {return}
            resultOperationLabel.text = text + String(number)
        }
    }
    
    @IBAction func didTapOperationButton(_ sender: UIButton) {
        let operation = Operators(rawValue: sender.tag) ?? .reset
        
        switch operation {
        case .dot:
            print("Punto")
        case .reset:
            resultOperationLabel.text = ""
            previousNumber = 0.0
            numberOnScreen = 0.0
            currentOperation = ""
        case .negative:
            print("Negativo")
        case .percentage:
            print("Porcentaje")
        case .division:
            setOperation(withOperator: "/")
        case .multiplication:
            setOperation(withOperator: "*")
        case .minus:
            setOperation(withOperator: "-")
        case .sum:
            setOperation(withOperator: "+")
        }
    }
    
    @IBAction func didTapShowResultButton(_ sender: UIButton) {
        /// Concatenamos los numeros con el operador Ej. (7 + 5)
        let operation = "\(previousNumber) \(currentOperation) \(numberOnScreen)"
        /// Creamos el NSExpression para realizar la operación
        let expression = NSExpression(format: operation)
        let result = expression.expressionValue(with: nil, context: nil) as? Double
        resultOperationLabel.text = String(formatResult(result: result!))
        
        isResultShowed = true
        previousNumber = 0.0
        numberOnScreen = 0.0
        currentOperation = ""
    }
    
    
    // MARK: - Private Functions
    
    /// Eat the provided specialty sloth food
    ///
    /// - Esto es una prueba
    /// - Test for the discussion
    /// - Parameters:
    ///   - bool: It´s a bool.
    ///   - string: It´s a string.
    /// - Returns: The sloth's energy level after eating.
    func test(bool: Bool, string: String) -> Int {
        return 0
    }
    
    /// Función que ayuda para colocar la lógica de la operación matemática
    ///
    /// En esta función se almacena el anterior número, se coloca el operador en la vista del usuario y se usa el boolean isClickingOperation
    /// para saber que el usuario le dio click a una operación
    ///
    /// - Parameters:
    ///    - withOperator: Operador que el usuario le dio click
    private func setOperation(withOperator: String) {
        guard let number = resultOperationLabel.text else {return}
        previousNumber = number.getDouble()
        isClickingOperation = true
        resultOperationLabel.text = withOperator
        currentOperation = withOperator
    }
    
    private func formatResult(result: Double) -> String {
        if (result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
}

private extension String {
    func getDouble() -> Double {
        return Double(self) ?? 0.0
    }
}
