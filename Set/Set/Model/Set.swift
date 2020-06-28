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
    
    
    /// compares
    // return an array of properties that they have in common
    private func compare(firstcard: Card,and secondCard: Card) -> [Property]?  {
        // holds the properties that are similar between the two cards
        var propertiesThatAreSimilar: [Property] = []
        
        for (cp1) in (firstcard.properties) {
            if (secondCard.contains(property: cp1)) { propertiesThatAreSimilar.append(cp1) }
        }
        // returns the array of properties
        return (propertiesThatAreSimilar.isEmpty) ? nil : propertiesThatAreSimilar
    }
    
    func isASet(cards: [Card]? = nil) -> Bool {
        
        let amount = cards ?? selectedCards
//        print(amount) // FIX ME:
        
        if amount.count < Constants.totalCardsRequiredForASet {return false}
      
        var aSetHasBeenFound = false
        
        // check if first two cards have a similarity
        if let similarProperties = compare(firstcard: amount[0], and: amount[1]) {
            // if they do then check if the properties they have in common are found in the thirdCard
            similarProperties.forEach { property in
                // if any of the similary properties are found in the third card, then it is a set.
                if (amount[2].contains(property: property)) {
                    // if the the properties are found in the third card then it is a set
                    aSetHasBeenFound = true
                }
            }
            // if no similarity has been found, return false.
            return (aSetHasBeenFound)
        }
        // if they dont
        // Then check if cardTwo and CardOne have anything in common with cardThree
        // if no similaries are found then they are a set.
        return (compare(firstcard: amount[0], and: amount[2]) == nil && compare(firstcard: amount[1], and: amount[2]) == nil)
    }
    
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
                    if isASet(cards: [firstCard, secondCard, thirdCard]) {
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
        // replace this function with normal code
         penalizeIfThereIsASet()
    }
    
    // penalizes if there cheatPair
    func penalizeIfThereIsASet() {
        if cheatPair.count > 0 { score -= 5 }
    }
    
    
    /// new game description
    func newGame() {
        fullDeckOfCards.removeAll(); table.removeAll(); score = 0
        createAFullDeck()
        fullDeckOfCards.shuffle();
        score = 0
        selectedCards.removeAll()
        cheatPair.removeAll()
        
        // add 12 cards into table from cards
        table.append(contentsOf: fullDeckOfCards[0..<12])
        // removes cards from
        fullDeckOfCards.removeSubrange(0..<12)
    }
    
    /// deals three cards into table
       func dealCard() {
           if selectedCards.count == 3 && isASet() && !fullDeckOfCards.isEmpty {
                // TODO: Update score
               selectedCards.forEach { (card) in
                   let index = table.firstIndex(of: card)!
                   table[index] = fullDeckOfCards.removeFirst()
               }
               selectedCards.removeAll()
           } else if (selectedCards.count == 3 && isASet() && fullDeckOfCards.isEmpty) {
                // TODO: Update score
               // remove just from the full deck of Cards
            selectedCards.forEach { (card) in
                table.removeAll(where: {$0 == card})
            }
               
           } else if (selectedCards.count == 3 && !isASet()) {
               calculateScore(aSet: false)
            selectedCards.removeAll()
           } else {
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
        if selectedCards.count ==  Constants.totalCardsRequiredForASet - 1 { selectedCards.append(card); calculateScore(aSet: isASet()); return }
          
        // add commenting
        // take into account when the user has
        if selectedCards.count == 3 {
            if (isASet()) {
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
    init() {  newGame();  }
    
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
