//
//  Set.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation


struct Constants {
    static let totalPropertiesInCards = 3
    static let shapes: [Shape] = [Shape.circle, .square, .triangle]
    static let shadings: [Shading] = [Shading.solid, .striped, .open]
    static let colors: [Color] = [Color.red, .green, .purple]
    static let numbers: [Number] = [Number.one, Number.two, Number.two]
    static let properties: [Any] = [shapes, shadings, colors, numbers]
}


class Set {
    
    /// full deck
    private(set) var cards: [Card] = []
    
    // deck
    
    // score
    
    
    /// Select card
    // function that selects card
    
    
    /// deal three cards
    
    
    /// new game
    
    
    /// cheat function
    
    // creates a full deck of 81 cards
    // TODO:
    func createAFullDeck() {
        
        // Shapes changes
        for ss in 0..<Constants.totalPropertiesInCards {
            // shadings changes
            for s in 0..<Constants.totalPropertiesInCards {
                // colors changes
                for c in 0..<Constants.totalPropertiesInCards {
                    // number changes
                    for n in 0..<Constants.totalPropertiesInCards {
                        let card = Card(shape: Constants.shapes[ss], shading: Constants.shadings[s], color: Constants.colors[c], number: Constants.numbers[n])
                        cards.append(card)
                    }
                }
            }
        }
    }
}
