import UIKit

class CalculatorViewController: UIViewController, NumericKeyboardDelegate {
    
    var logic = DarkCalcLogic()
    var firstValue: Double = -1
    var secondValue: Double = -1
    var operation: Operation?
    var result: Double = 0
    
    lazy var containerDisplayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var displayTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Arial", size: 25)
        textField.layer.cornerRadius = 10
        textField.isUserInteractionEnabled = false
        textField.textAlignment = .right
        textField.text = "0"
        return textField
    }()
    
    var numericKeyboard: CalculatorNumericKeyboard = {
        let keyboard = CalculatorNumericKeyboard()
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        return keyboard
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        numericKeyboard.delegate = self
        setComponents()
        setConstraint()
    }
    
    func setComponents() {
        view.addSubview(containerDisplayView)
        containerDisplayView.addSubview(displayTextField)
        view.addSubview(numericKeyboard)
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            containerDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerDisplayView.heightAnchor.constraint(equalToConstant: 100),
            
            displayTextField.topAnchor.constraint(equalTo: containerDisplayView.topAnchor, constant: 5),
            displayTextField.leadingAnchor.constraint(equalTo: containerDisplayView.leadingAnchor, constant: 5),
            displayTextField.trailingAnchor.constraint(equalTo: containerDisplayView.trailingAnchor, constant: -5),
            displayTextField.bottomAnchor.constraint(equalTo: containerDisplayView.bottomAnchor, constant: -5),
            
            numericKeyboard.topAnchor.constraint(equalTo: containerDisplayView.bottomAnchor, constant: 0.5),
            numericKeyboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            numericKeyboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            numericKeyboard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func getValue(character: String) {
        guard let text = displayTextField.text else {displayTextField.text = character
            return}
        
        var numbers: [String] = []
        for number in 0...9 {
            numbers.append(String(number))
        }
        
        if numbers.contains(character) {
            if result != 0 {
                displayTextField.text = character
                firstValue = result
                result = 0
            } else {
                displayTextField.text = text + character
            }
        } else {
            switch character {
            case "AC":
                displayTextField.text = "0"
                reset()
                result = 0
            case "+":
                setValue(character: character)
                operation = .sum
            case "-":
                setValue(character: character)
                operation = .subtraction
            case "*":
                setValue(character: character)
                operation = .multiplier
            case "/":
                setValue(character: character)
                operation = .divider
            case "ˆ":
                setValue(character: character)
                operation = .pow
            case "%":
                setValue(character: character)
                operation = .percentage
            case "=":
                setValue(character: character)
            case ".":
                guard let text = displayTextField.text else {return}
                for char in text {
                    if char == Character(character) {
                        return
                    }
                }
                displayTextField.text = text + character
            default:
                displayTextField.text = "Error"
            }
        }
    }
    
    func setValue(character: String) {
        if firstValue == -1 {
            firstValue = Double(displayTextField.text ?? "0") ?? 0
            displayTextField.text = "0"
        } else {
            secondValue = Double(displayTextField.text ?? "0") ?? 0
            guard let operation = operation else {return}
            result = logic.calculate(firstValue: firstValue, secondValue: secondValue, operation: operation)
            displayTextField.text = String(result)
            reset()
        }
    }
    
    func reset() {
        firstValue = -1
        secondValue = -1
        operation = nil
    }
}

