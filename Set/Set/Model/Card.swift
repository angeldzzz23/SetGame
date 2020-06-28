//
//  Card.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation


class Card: Equatable, CustomStringConvertible {
    
    
    var number: Number
    var shape: Shape
    var shading: Shading
    var color: Color
    
    var description: String {
        return "Shape: \(shape), Shading: \(shading), Color: \(color), Number: \(number)"
    }
    
    lazy var properties: [Property] = [number, shape, shading, color]
    
    init(shape: Shape, shading: Shading, color: Color, number: Number) {
        self.shape = shape
        self.shading = shading
        self.color = color
        self.number = number
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.number == rhs.number) && (lhs.shape == rhs.shape )  && (lhs.color == rhs.color ) && (lhs.shading == rhs.shading )
      }
    
    /// checks if a certain property is in the Card
    /// Will return false if it is not.
    func contains<T>(property: T) -> Bool {
        if let shape = property as? Shape {
            return (self.shape == shape)
        } else if let shading = property as? Shading {
            return (self.shading == shading)
        } else if let color = property as? Color {
            return (self.color == color)
        } else if let number = property as? Number {
            return (self.number == number)
        }
        return false
    }
    
}



