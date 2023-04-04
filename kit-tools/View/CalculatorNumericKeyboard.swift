import UIKit

protocol NumericKeyboardDelegate {
    func getValue(character: String)
}

class CalculatorNumericKeyboard: UIStackView {
    var delegate: NumericKeyboardDelegate?
    
    lazy var arrayOfNumbers: [UIButton] = {
        var array: [UIButton] = []
        for number in 0...9 {
            array.append(setButton(title: String(number), backgroundColor: .lightGray))
        }
        return array
    }()
    
    lazy var arrayOfStackView: [UIStackView] = {
        var array: [UIStackView] = []
        for number in 0...5 {
            array.append(setStackView())
        }
        return array
    }()
    
    lazy var ac: UIButton = setButton(title: "AC", backgroundColor: .darkGray)
    lazy var pow: UIButton = setButton(title: "ˆ", backgroundColor: .darkGray)
    lazy var percentagem: UIButton = setButton(title: "%", backgroundColor: .darkGray)
    lazy var divider: UIButton = setButton(title: "/", backgroundColor: .black)
    lazy var multiplier: UIButton = setButton(title: "*", backgroundColor: .black)
    lazy var subtraction: UIButton = setButton(title: "-", backgroundColor: .black)
    lazy var plus: UIButton = setButton(title: "+", backgroundColor: .black)
    lazy var numberZero: UIButton = setButton(title: "0", backgroundColor: .lightGray)
    lazy var dot: UIButton = setButton(title: ".", backgroundColor: .lightGray)
    lazy var equal: UIButton = setButton(title: "=", backgroundColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSelf()
        self.setComponents()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSelf() {
        self.distribution = .fillEqually
        self.alignment = .fill
        self.axis = .vertical
        self.spacing = 0.5
        self.layer.borderWidth = 0.6
    }
    
    func setStackView() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 0.5
        return stack
    }
    
    func setButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 22)
        button.addTarget(self, action: #selector(sender(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setComponents() {
        self.addArrangedSubview(arrayOfStackView[0])
        arrayOfStackView[0].addArrangedSubview(ac)
        arrayOfStackView[0].addArrangedSubview(pow)
        arrayOfStackView[0].addArrangedSubview(percentagem)
        arrayOfStackView[0].addArrangedSubview(divider)
        self.addArrangedSubview(arrayOfStackView[1])
        arrayOfStackView[1].addArrangedSubview(arrayOfNumbers[7])
        arrayOfStackView[1].addArrangedSubview(arrayOfNumbers[8])
        arrayOfStackView[1].addArrangedSubview(arrayOfNumbers[9])
        arrayOfStackView[1].addArrangedSubview(multiplier)
        self.addArrangedSubview(arrayOfStackView[2])
        arrayOfStackView[2].addArrangedSubview(arrayOfNumbers[4])
        arrayOfStackView[2].addArrangedSubview(arrayOfNumbers[5])
        arrayOfStackView[2].addArrangedSubview(arrayOfNumbers[6])
        arrayOfStackView[2].addArrangedSubview(subtraction)
        self.addArrangedSubview(arrayOfStackView[3])
        arrayOfStackView[3].addArrangedSubview(arrayOfNumbers[1])
        arrayOfStackView[3].addArrangedSubview(arrayOfNumbers[2])
        arrayOfStackView[3].addArrangedSubview(arrayOfNumbers[3])
        arrayOfStackView[3].addArrangedSubview(plus)
        self.addArrangedSubview(arrayOfStackView[4])
        arrayOfStackView[4].addArrangedSubview(arrayOfStackView[5])
        arrayOfStackView[4].addArrangedSubview(equal)
        arrayOfStackView[5].addArrangedSubview(numberZero)
        arrayOfStackView[5].addArrangedSubview(dot)
    }
    
    @objc func sender(sender: UIButton) {
        delegate?.getValue(character: sender.titleLabel?.text ?? "")
    }
}
