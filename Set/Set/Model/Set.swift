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
    
    /// full deck of cards
    private(set) var cards: [Card] = []
    
    /// user table
    private var table:[Card] = []
    
    /// current score
    private var score = 0
    
    /// Selected cards
    private var selectedCards:[Card] = []
    
    
    
    /// deals three cards into table
    func dealCard() {
        table.append(cards.remove(at: 0))
    }
    
    /// new game
    // reset score, set
    func newGame() {
        cards.removeAll(); table.removeAll(); score = 0
        createAFullDeck()
        // add 12 cards into table from cards
        table.append(contentsOf: cards[0..<12])
        // removes cards from
        cards.removeSubrange(0..<12)
    }
    
    /// select Card
    func select(card:Card) {
        selectedCards.append(card)
    }
    
    /// cheat function
    
    // creates a full deck of 81 cards
    // find a way to make this simple
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
    
    init() {
        // start a new game
       newGame()
    }
}
