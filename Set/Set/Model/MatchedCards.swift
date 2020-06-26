//
//  MatchedCards.swift
//  Set
//
//  Created by angel zambrano on 6/26/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation

class MatchedCards: Equatable {
    var card1: Card
    var card2: Card
    var card3: Card
    
    lazy var cards = [card1, card2, card3]
    
    static func == (lhs: MatchedCards, rhs: MatchedCards) -> Bool {
        var cardCount = 0
        
        for lhscard in lhs.cards {
            if rhs.cards.contains(lhscard) {
                cardCount += 1
            }
        }

        return (cardCount == 3) ? true : false
    }
    
    init(card1: Card, card2: Card,card3: Card ) {
        self.card1 = card1
        self.card2 = card2
        self.card3 = card3
    }
    
}
