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
    
    lazy var set =  Set()
    
    // mapping properties
    let color: [Card.Color1: UIColor] = [.red: #colorLiteral(red: 0.8117647059, green: 0.4, blue: 0.4745098039, alpha: 1), .green: #colorLiteral(red: 0.01176470588, green: 0.8549019608, blue: 0.7764705882, alpha: 1) , .purple: #colorLiteral(red: 0.6666666667, green: 0.1127794535, blue: 1, alpha: 1)]
    let shape: [Card.Shape1: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
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
    
    func updateUI() {
        // the initialState for all cards
        for card in cards {
           card.alpha = 0
           card.setAttributedTitle(nil, for: .normal)
           card.setTitle(nil, for: .normal)
        }
        set.table.enumerated().forEach {  (index, card) in
            let cardButton = cards[index]
            cardButton.alpha = 1
            cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            // set the attributes of the buttons
            cardButton.setAttributedTitle(getAttributedText(cardButton: card), for: .normal)
        }
    }

    @IBAction func CardWasPressed(_ sender: UIButton) {
        if let card = cards.firstIndex(of: sender) {
            print(card)
          } else {
                  
          }
    }
    
    func getAttributedText(cardButton: Card) ->NSAttributedString{
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
