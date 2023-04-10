import Foundation

enum Operation {
    case sum
    case subtraction
    case divider
    case multiplier
    case pow
    case percentage
}

class DarkCalcLogic {
    
    func calculate(firstValue: Double, secondValue: Double, operation: Operation) -> Double {
        var result: Double
        
        switch operation {
        case .sum:
            result = firstValue + secondValue
        case .subtraction:
            result = firstValue - secondValue
        case .multiplier:
            result = firstValue * secondValue
        case .divider:
            result = firstValue / secondValue
        case .pow:
            result = pow(firstValue, secondValue)
        case .percentage:
            result = firstValue / 100 * secondValue
        }
        return result
    }
}
