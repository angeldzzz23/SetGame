//
//  Card.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation


class Card: Properties, Equatable {
    var number: Number1
    var shape: Shape1
    var shading: Shading1
    var color: Color1
    
    lazy var properties: [random] = [number, shape, shading, color]
    
    
    
    init(shape: Shape1, shading: Shading1, color: Color1, number: Number1) {
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
        if let shape = property as? Shape1 {
            return (self.shape == shape)
        } else if let shading = property as? Shading1 {
            return (self.shading == shading)
        } else if let color = property as? Color1 {
            return (self.color == color)
        } else if let number = property as? Number1 {
            return (self.number == number)
        }
        return false
    }
    
}



