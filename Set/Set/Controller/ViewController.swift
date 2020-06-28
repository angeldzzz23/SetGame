//
//  ViewController.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    /// the main set game.
    lazy var set =  Set()
    
    /// the card buttons being displayed in the UI
    @IBOutlet var cards: [UIButton]!
    
    /// The deal more button in the UI.
    @IBOutlet weak var dealCardButton: UIButton!
    
    /// The UI score label.
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    /// The mapping between a symbol card feature and it's
    /// corresponding displayable char.
    
    let shape: [Shape: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    
    /// The mapping between a color card feature and it's
    /// corresponding literal displayable UIColor.
    let color: [Color: UIColor] = [.red: #colorLiteral(red: 0.8117647059, green: 0.4, blue: 0.4745098039, alpha: 1), .green: #colorLiteral(red: 0.01176470588, green: 0.8549019608, blue: 0.7764705882, alpha: 1) , .purple: #colorLiteral(red: 0.6666666667, green: 0.1127794535, blue: 1, alpha: 1)]
    
    
    let card1 = Card(shape: .circle, shading: .open, color: .green, number: .two)
    
    
    // MARK: Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        
    }
    
    
    /// retruns the correct card string symbol with appropriate number
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
    
    /// Returns the configured attributed text for the given card,
    /// configured based on the card features.
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
    
    /// Displays each card dealt by the setGame.
    /// Method in chard of keeping the UI in sync with the model.
    func updateUI() {
        
        // the initialState for all cards
        cards.forEach({$0.alpha = 0; $0.setAttributedTitle(nil, for: .normal); $0.setTitle(nil, for: .normal) })
        
        
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
            
            // get rid of the border for the cards that were used to cheat
            cardButton.layer.borderWidth = 0
        }
        
        
        // update cards if 3 cards have been chosen
        if set.selectedCards.count == Constants.totalPropertiesInCards {
            let cardOne = set.table.firstIndex(of: set.selectedCards[0])!
            let cardTwo = set.table.firstIndex(of: set.selectedCards[1])!
            let cardThree = set.table.firstIndex(of: set.selectedCards[2])!
            if set.isASet() {
                cards[cardOne].backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
                cards[cardTwo].backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
                cards[cardThree].backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
            } else {
                cards[cardOne].backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
                cards[cardTwo].backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
                cards[cardThree].backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
            }
        }
        
        // update cheat cards
        if set.cheatPair.count == Constants.totalCardsRequiredForASet {
            if let index = set.table.firstIndex(of: set.cheatPair[0]) {
                cards[index].layer.borderWidth = 1
                cards[index].layer.borderColor = #colorLiteral(red: 1, green: 0.7954385166, blue: 0, alpha: 1)
            }
            
            if let index = set.table.firstIndex(of: set.cheatPair[1]) {
                
                cards[index].layer.borderWidth = 1
                cards[index].layer.borderColor = #colorLiteral(red: 1, green: 0.7954385166, blue: 0, alpha: 1)
            }
            
            if let index = set.table.firstIndex(of: set.cheatPair[2]) {
                cards[index].layer.borderWidth = 1
                cards[index].layer.borderColor = #colorLiteral(red: 1, green: 0.7954385166, blue: 0, alpha: 1)
            }
        }
        
        // deal card button default settings
        dealCardButton.isEnabled = true
        dealCardButton.setTitle("Deal Cards", for: .normal)
        
        // disables deal card button if there are 24 cards or if the fullDeck is empty
        if set.table.count == cards.count || set.fullDeckOfCards.isEmpty {
            dealCardButton.isEnabled = false
            dealCardButton.setTitle("", for: .normal)
        }
        
        // update selected cards
        scoreLabel.text = String(set.score)
    }
    
    // MARK: Actions
    
    /// Adds more cards to the UI.
    @IBAction func dealCardButtonWasPressed(_ sender: UIButton) {
        if set.table.count < cards.count {
            set.dealCard()
        }
        updateUI()
    }
    
    /// Selects the chosen card.
    @IBAction func CardWasPressed(_ sender: UIButton) {
        if let index = cards.firstIndex(of: sender) {
            set.select(card: set.table[index])
            updateUI()
        }
    }
    
    @IBAction func cheatButtonWasPressed(_ sender: UIButton) {
        set.cheat()
        updateUI()
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
    
}
