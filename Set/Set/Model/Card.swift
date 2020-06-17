//
//  Card.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation


class Card {
    var number: Number
    var shape: Shape
    var shading: Shading
    var color: Color
    
    init(shape: Shape, shading: Shading, color: Color, number: Number) {
        self.shape = shape
        self.shading = shading
        self.color = color
        self.number = number
    }
}
