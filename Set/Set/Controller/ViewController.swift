//
//  ViewController.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet var cards: [UIButton]!
    @IBOutlet weak var dealCardButton: UIButton!
    @IBOutlet weak var scoreButton: UILabel!
    lazy var set =  Set()
    
    // mapping properties
    let color: [Card.Color1: UIColor] = [.red: #colorLiteral(red: 0.8117647059, green: 0.4, blue: 0.4745098039, alpha: 1), .green: #colorLiteral(red: 0.01176470588, green: 0.8549019608, blue: 0.7764705882, alpha: 1) , .purple: #colorLiteral(red: 0.6666666667, green: 0.1127794535, blue: 1, alpha: 1)]
    let shape: [Card.Shape1: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        
        if let randomPair = getRandomSet(cardssss: set.table) {
            if let index = set.table.firstIndex(of: randomPair.card1) {
//                cards[index].backgroundColor = .green
                cards[index].layer.borderWidth = 1
                cards[index].layer.borderColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
            } else {
                print(randomPair.card3)
            }

              if let index = set.table.firstIndex(of: randomPair.card2) {

                cards[index].layer.borderWidth = 1
                cards[index].layer.borderColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
              } else {
                  print(randomPair.card3)
              }
              
              if let index = set.table.firstIndex(of: randomPair.card3) {
                cards[index].layer.borderWidth = 1
                cards[index].layer.borderColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
              } else {
                  print(randomPair.card3)
              }
        }

    }
    
    
    func getRandomSet(cardssss: [Card]) -> MatchedCards? {
        var firstArray = cardssss
        var numpairOfMatches: [MatchedCards] = []
        
        for firstCard in firstArray {
            firstArray.removeAll(where: {$0 == firstCard})
            for secondCard in firstArray {
                firstArray.removeAll(where: {$0 == secondCard})
                for thirdCard in firstArray {
                    if cardsAreASet(cardsWithSimiliaries: [firstCard, secondCard, thirdCard]) {
                        let mCards: MatchedCards = MatchedCards(card1: firstCard, card2: secondCard, card3: thirdCard)
                        if !numpairOfMatches.contains(mCards) {
                            numpairOfMatches.append(mCards)
                        } else {
                            
                        }
                    }
                }
                firstArray.append(secondCard)
            }
            firstArray.append(firstCard)
        }
        
        if numpairOfMatches.count > 0 {
            let r = Int.random(in: 0..<numpairOfMatches.count)
            return numpairOfMatches[r]
        }
        return nil
    }

    
    func cardsAreASet(cardsWithSimiliaries: [Card]) -> Bool {
        
     if cardsWithSimiliaries.count < 3 {return false}
        var aSetHasBeenFound = false
             // check if first two cards have a similarity
             if let similarProperties = compare(firstcard: cardsWithSimiliaries[0], and: cardsWithSimiliaries[1]) {
                 // if they do then check if the properties they have in common are found in the thirdCard
                 similarProperties.forEach { property in
                     // if any of the similary properties are found in the third card, then it is a set.
                     if (cardsWithSimiliaries[2].contains(property: property)) {
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
             return (compare(firstcard: cardsWithSimiliaries[0], and: cardsWithSimiliaries[2]) == nil && compare(firstcard: cardsWithSimiliaries[1], and: cardsWithSimiliaries[2]) == nil)
    }
    
    
    /// retruns the mapped card symbol
    func getShapeWithAppropriateNumber(card: Card) -> String {
        switch card.number {
        case .one:
            return shape[card.shape]!
        case .two:
            return shape[card.shape]! + shape[card.shape]!
        case .three:
            return shape[card.shape]! + shape[card.shape]! + shape[card.shape]!
        }
    }
    
     func compare(firstcard: Card,and secondCard: Card) -> [random]?  {
        // holds the properties that are similar between the two cards
        var propertiesThatAreSimilar: [random] = []
        
        for (cp1) in (firstcard.properties) {
            if (secondCard.contains(property: cp1)) { propertiesThatAreSimilar.append(cp1) }
        }
        // returns the array of properties
        return (propertiesThatAreSimilar.isEmpty) ? nil : propertiesThatAreSimilar
    }
    
    func updateUI() {
        // the initialState for all cards
        for card in cards {
           card.alpha = 0
           card.setAttributedTitle(nil, for: .normal)
           card.setTitle(nil, for: .normal)
        }
        
        // loop through each button and update their properties
        set.table.enumerated().forEach {  (index, card) in
            let cardButton = cards[index]
            cardButton.alpha = 1
           
            // set the attributes of the button
            cardButton.setAttributedTitle(getAttributedText(cardButton: card), for: .normal)
            
            // update cards that have been selected by the user
            if (set.selectedCards.contains(card)) {
                cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                 cardButton.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
            }
            
            // let user know that they have a match.
            if (set.selectedCards.count == 3) {
                if set.isASet() && set.selectedCards.contains(card) {
                    cardButton.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
                } else if !set.isASet() && set.selectedCards.contains(card) {
                   cardButton.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
                }
            }
        }
        
        // deal card button default settings
        dealCardButton.isEnabled = true
        dealCardButton.setTitle("Deal Cards", for: .normal)
     
        if set.table.count == cards.count || set.fullDeckOfCards.isEmpty {
            dealCardButton.isEnabled = false
            dealCardButton.setTitle("", for: .normal)
        }
        // update score button
        set.updateScore()
        scoreButton.text = String(set.score)
    }
    
    @IBAction func dealCardButtonWasPressed(_ sender: UIButton) {
        // the
        if set.table.count < cards.count {
            set.dealCard()
        }
        updateUI()
    }
    
    
    @IBAction func CardWasPressed(_ sender: UIButton) {
        if let index = cards.firstIndex(of: sender) {
            set.select(card: set.table[index])
            updateUI()
          }
    }
    
    @IBAction func cheatButtonWasPressed(_ sender: UIButton) {
        
    }
    
    
    
    
    func getAttributedText(cardButton: Card) ->NSAttributedString {
        var attributes = [NSAttributedString.Key : Any]()
        switch (cardButton.shading) {
        case .open: // outlined
              attributes[NSAttributedString.Key.strokeWidth] = 10
            break
        case .solid:
            attributes[NSAttributedString.Key.foregroundColor] = color[cardButton.color]!.withAlphaComponent(100)
            break
        case .striped:
             attributes[NSAttributedString.Key.foregroundColor] = color[cardButton.color]!.withAlphaComponent(0.3)
            break
        }
        return NSAttributedString(string: getShapeWithAppropriateNumber(card: cardButton), attributes: attributes)
    }
}
