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
    static let totalCardsRequiredForASet = 3
    static let colors: [Color] = [Color.green, Color.red, Color.purple]
    static let shapes: [Shape] =  [Shape.circle, .square, .triangle]
    static let shadings: [Shading] = [Shading.solid, .striped, .open]
    static let numbers: [Number] = [Number.one, .two, .three]
    static let properties: [Any] = [shapes, shadings, colors, numbers]
}

class Set {
    /// full deck of cards
    private(set) var fullDeckOfCards: [Card] = []
    /// user table
    private(set) var table:[Card] = []
    /// current score
    private(set) var score = 0
    /// Selected cards
    private(set) var selectedCards:[Card] = []
    
    /// containts the 3 cards  which are a set
    private(set) var cheatPair: [Card] = []
    private var date = Date()
    
    
    /// intializes cheatPair with three cards that are a set
    // optimize it to make it faster
    func cheat() {
        cheatPair.removeAll()
        var firstArray = table
        var numpairOfMatches: [MatchedCards] = []
        
        // add comment
        for firstCard in firstArray {
            firstArray.removeAll(where: {$0 == firstCard})
            for secondCard in firstArray {
                firstArray.removeAll(where: {$0 == secondCard})
                for thirdCard in firstArray {
                    if cardsAreASet(cardOne: firstCard, cardTwo: secondCard, cardThree: thirdCard) {
                        let mCards: MatchedCards = MatchedCards(card1: firstCard, card2: secondCard, card3: thirdCard)
                        if !numpairOfMatches.contains(mCards) {
                            numpairOfMatches.append(mCards)
                            break
                        }
                    }
                    
                }
                firstArray.append(secondCard)
            }
            firstArray.append(firstCard)
        }
        // appending cheat cards if there are more than one
        if numpairOfMatches.count > 0 {
            let r = Int.random(in: 0..<numpairOfMatches.count)
            cheatPair.append(numpairOfMatches[r].card1)
            cheatPair.append(numpairOfMatches[r].card2)
            cheatPair.append(numpairOfMatches[r].card3)
            
        } else {
            print("there is no set")
        }
        print(numpairOfMatches.count)
        // replace this function with normal code
        penalizeIfThereIsASet()
    }
    
    /// returns an array of properties that they have in common
    ///
    /// - Parameter firstcard: the features to be iterated and added to the cards in each call.
    /// - Parameter secondCard: dededdwdeded
    func cardsAreASet(cardOne: Card, cardTwo: Card, cardThree: Card) -> Bool {
        
        if !(cardOne.color == cardTwo.color && cardOne.color == cardThree.color && cardTwo.color == cardThree.color
            || cardOne.color != cardTwo.color && cardOne.color != cardThree.color && cardTwo.color != cardThree.color) {
            return false
        }
        
        if !(cardOne.shape == cardTwo.shape && cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape
            || cardOne.shape != cardTwo.shape && cardOne.shape != cardThree.shape && cardTwo.shape != cardThree.shape) {
            return false
        }
        
        if !(cardOne.shading == cardTwo.shading && cardOne.shading == cardTwo.shading && cardTwo.shading == cardThree.shading
            || cardOne.shading != cardTwo.shading && cardOne.shading != cardThree.shading && cardTwo.shading != cardThree.shading) {
            return false
        }
        
        if !(cardOne.number == cardTwo.number && cardOne.number == cardThree.number && cardTwo.number == cardThree.number
            || cardOne.number != cardTwo.number && cardOne.number != cardThree.number && cardTwo.number != cardThree.number) {
            return false
        }
        
        return true
    }
    
    
    // penalizes if there cheatPair
    func penalizeIfThereIsASet() {
        if cheatPair.count > 0 { score -= 5 }
    }
    
    /// new game description
    func newGame() {
        fullDeckOfCards.removeAll(); table.removeAll(); score = 0
        createAFullDeck(); fullDeckOfCards.shuffle(); score = 0; selectedCards.removeAll(); cheatPair.removeAll();
        fullDeckOfCards.shuffle()
        // add 12 cards into table from cards
        table.append(contentsOf: fullDeckOfCards[0..<12])
        // removes cards from
        fullDeckOfCards.removeSubrange(0..<12)
    }
    
    /// deals three cards into table
    func dealCard() {
        if selectedCards.count == 3 {
            if cardsAreASet(cardOne: selectedCards[0], cardTwo: selectedCards[1], cardThree: selectedCards[2]) && !fullDeckOfCards.isEmpty {
                // TODO: Update score
                selectedCards.forEach { (card) in
                    let index = table.firstIndex(of: card)!
                    table[index] = fullDeckOfCards.removeFirst()
                }
                selectedCards.removeAll()
            }
            else if (cardsAreASet(cardOne: selectedCards[0], cardTwo: selectedCards[1], cardThree: selectedCards[2]) && fullDeckOfCards.isEmpty) {
                // TODO: Update score
                // remove just from the full deck of Cards
                selectedCards.forEach { (card) in
                    table.removeAll(where: {$0 == card})
                }
                
            } else if (!cardsAreASet(cardOne: selectedCards[0], cardTwo: selectedCards[1], cardThree: selectedCards[2])) {
                calculateScore(aSet: false)
                selectedCards.removeAll()
            }
        }
        else {
            table.append(contentsOf: fullDeckOfCards[0..<3])
            fullDeckOfCards.removeSubrange(0..<3)
        }
    }
    
    /// select Card
    // FIX:
    func select(card:Card) {
        // deselect or select card card or ch
        if selectedCards.contains(card) {
            // detects when user tries to deselect when there are already 3 cards being selected
            if selectedCards.count == 3 { return }
            // deselects repeated cards
            selectedCards.removeAll(where:{ $0 == card}); return
        }
        // calculates score when the user enters the third card.
        if selectedCards.count ==  Constants.totalCardsRequiredForASet - 1 { selectedCards.append(card); calculateScore(aSet: cardsAreASet(cardOne: selectedCards[0], cardTwo: selectedCards[1], cardThree: selectedCards[2])); return }
        
        // add commenting
        // take into account when the user has
        if selectedCards.count == 3 {
            if (cardsAreASet(cardOne: selectedCards[0], cardTwo: selectedCards[1], cardThree: selectedCards[2])) {
                // update
                for selectedCard in selectedCards {
                    table.removeAll(where: {$0 == selectedCard && !($0 == card)})
                }
                // remove all selected cards except the forth card
                selectedCards.removeAll(where: {$0 != card})
            } else {
                // update score
                selectedCards.removeAll()
            }
        }
        selectedCards.append(card)
    }
    
    // creates a full deck of 81 cards
    func createAFullDeck() {
        // shapes
        for ss in 0..<Constants.totalPropertiesInCards {
            // shadings changes
            for s in 0..<Constants.totalPropertiesInCards {
                // colors changes
                for c in 0..<Constants.totalPropertiesInCards {
                    // number changes
                    for n in 0..<Constants.totalPropertiesInCards {
                        let card = Card(shape: Constants.shapes[ss], shading: Constants.shadings[s], color: Constants.colors[c], number: Constants.numbers[n])
                        fullDeckOfCards.append(card)
                    }
                }
            }
        }
    }
    init() {  newGame(); }
    
    func calculateScore(aSet: Bool) {
        let timeInSeconds = abs(date.timeIntervalSinceNow)
        if (timeInSeconds <= 15) {
            if aSet {score += 4} else { score -= 3 }
            
        } else if (timeInSeconds > 15) {
            if aSet {score += 1} else { score -= 5 }
        }
        date = Date()
    }
}
