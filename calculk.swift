//
//  calculk.swift
//  caulk
//
//  Created by nju on 2021/10/13.
//

import UIKit

class calculk: NSObject {
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    var operations = [
        "+": Operation.BinaryOp{
            (op1,op2) in
            return op1 + op2
        },
        "-": Operation.BinaryOp{
            (op1,op2) in
            return op1 - op2
        },
        "*": Operation.BinaryOp{
            (op1,op2) in
            return op1 * op2
        },
        "/": Operation.BinaryOp{
            (op1,op2) in
            return op1 / op2
        },
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        "=": Operation.EqualOp,
        "%": Operation.UnaryOp{
            op in
            return op / 100.0
        },
        "AC": Operation.UnaryOp{
            _ in
            return 0
        },
        "x!": Operation.UnaryOp{
            op in
            var re = 1;
            for i in 1..<Int(op){
                re = re * i
            }
            return Double(re)
        },
        "squre": Operation.UnaryOp{
            op in
            return sqrt(op)
        },
        "x^2": Operation.UnaryOp{
            op in
            return op*op
        },
        "x^3": Operation.UnaryOp{
            op in
            return op*op*op
        },
        "x^y": Operation.BinaryOp{
            (op1,op2) in
            return pow(op1,op2)
        },
        "e^x": Operation.UnaryOp{
            op in
            return pow(2.718,op)
        },
        "10^x": Operation.UnaryOp{
            op in
            return pow(10,op)
        },
        "1/x": Operation.UnaryOp{
            op in
            return 1/op
        },
        "sin": Operation.UnaryOp{
            op in
            return sin(op*3.141592653/180)
        },
        "cos": Operation.UnaryOp{
            op in
            return cos(op*3.141592653/180)
        },
        "tan": Operation.UnaryOp{
            op in
            return tan(op*3.141592653/180)
        },
        "sinh": Operation.UnaryOp{
            op in
            return sinh(op*3.141592653/180)
        },
        "cosh": Operation.UnaryOp{
            op in
            return cosh(op*3.141592653/180)
        },
        "tanh": Operation.UnaryOp{
            op in
            return tanh(op*3.141592653/180)
        },
        "3saure": Operation.UnaryOp{
            op in
            return pow(op,1/3)
        },
        "x|y": Operation.BinaryOp{
            (op1,op2) in
            return pow(op1,1.0/op2)
        },
        "ln": Operation.UnaryOp{
            op in
            return log(op)
        },
        "log10": Operation.UnaryOp{
            op in
            return log10(op)
        },
        
        "pi": Operation.Constant(3.141592653),
        "e": Operation.Constant(2.718)
        ]
        struct Intermediate{
            var firstOp: Double
            var waitingOperation: (Double, Double) -> Double
        }
        var pendingOp: Intermediate? = nil
        func performOperation(operation: String, operand: Double) -> Double?{
            if let op = operations[operation] {
                switch op{
                case .BinaryOp(let function):
                    pendingOp = Intermediate(firstOp: operand, waitingOperation: function)
                    return nil
                case .Constant(let value):
                    return value
                case .EqualOp:
                    return pendingOp!.waitingOperation(pendingOp!.firstOp,operand)
                case .UnaryOp(let function):
                    return function(operand)
                }
                
            }
            return nil
        }
}
