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
    static let colors: [Properties.Color1] = [Properties.Color1.green, Properties.Color1.red, Properties.Color1.purple]
    static let shapes: [Properties.Shape1] =  [Properties.Shape1.circle, .square, .triangle]
    static let shadings: [Properties.Shading1] = [Properties.Shading1.solid, .striped, .open]
    static let numbers: [Properties.Number1] = [Properties.Number1.one, .two, .three]
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
    
      /// compares
       // return an array of properties that they have in common
      private func compare(firstcard: Card,and secondCard: Card) -> [random]?  {
           // holds the properties that are similar between the two cards
           var propertiesThatAreSimilar: [random] = []
           
           for (cp1) in (firstcard.properties) {
               if (secondCard.contains(property: cp1)) { propertiesThatAreSimilar.append(cp1) }
           }
           // returns the array of properties
           return (propertiesThatAreSimilar.isEmpty) ? nil : propertiesThatAreSimilar
       }
       
    
     
    func isASet(cards: [Card]? = nil) -> Bool {
        
        let amount = cards ?? selectedCards
        print(amount) // FIX ME:
        
        if amount.count < 3 {return false}
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
    
//    func cardsAreASet(cardsWithSimiliaries: [Card]) -> Bool {
//        if cardsWithSimiliaries.count < 3 {return false}
//           var aSetHasBeenFound = false
//                // check if first two cards have a similarity
//                if let similarProperties = compare(firstcard: cardsWithSimiliaries[0], and: cardsWithSimiliaries[1]) {
//                    // if they do then check if the properties they have in common are found in the thirdCard
//                    similarProperties.forEach { property in
//                        // if any of the similary properties are found in the third card, then it is a set.
//                        if (cardsWithSimiliaries[2].contains(property: property)) {
//                          // if the the properties are found in the third card then it is a set
//                            aSetHasBeenFound = true
//                        }
//                    }
//                    // if no similarity has been found, return false.
//                    return (aSetHasBeenFound)
//                }
//                // if they dont
//                // Then check if cardTwo and CardOne have anything in common with cardThree
//                // if no similaries are found then they are a set.
//                return (compare(firstcard: cardsWithSimiliaries[0], and: cardsWithSimiliaries[2]) == nil && compare(firstcard: cardsWithSimiliaries[1], and: cardsWithSimiliaries[2]) == nil)
//       }
    
    
    /// function that algorithm finds out the pairs of cards that are a match
    
    /// deals three cards into table
    func dealCard() {
        if selectedCards.count == 3 && isASet() && !fullDeckOfCards.isEmpty {
            selectedCards.forEach { (card) in
                let index = table.firstIndex(of: card)!
                table[index] = fullDeckOfCards.removeFirst()
            }
            selectedCards.removeAll()
        } else {
            table.append(contentsOf: fullDeckOfCards[0..<3])
            fullDeckOfCards.removeSubrange(0..<3)
        }
    }
    
    /// new game description
    func newGame() {
        fullDeckOfCards.removeAll(); table.removeAll(); score = 0
        createAFullDeck()
//        fullDeckOfCards.shuffle(); fullDeckOfCards.shuffle();
        // add 12 cards into table from cards
        table.append(contentsOf: fullDeckOfCards[0..<12])
        // removes cards from
        fullDeckOfCards.removeSubrange(0..<12)
    }

    /// select Card
    func select(card:Card) {
        selectedCards.contains(card) ? (selectedCards.removeAll(where:{ $0 == card})) : selectedCards.append(card)
        if selectedCards.count == 4 {
            if (isASet()) {
                for selectedCard in selectedCards {
                     table.removeAll(where: {$0 == selectedCard && !($0 == card)})
                }
                // remove all selected cards except the forth card
                selectedCards.removeAll(where: {$0 != card})
            } else {
                selectedCards.removeAll()
                selectedCards.append(card)
            }
        }
    }
    
    func updateScore() {
        if isASet() && selectedCards.count == 3 {score += 3} else if selectedCards.count == 3 { score -= 5 }
    }
    
    // creates a full deck of 81 cards
    // find a way to make this simple
    // TODO: Refactor
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
                        fullDeckOfCards.append(card)
                    }
                      
                }
                  
            }
            
        }
    }
    init() {  newGame();  }
}
