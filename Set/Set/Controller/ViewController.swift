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
    
    var numbers : [[Int]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
  
    
    @IBAction func CardWasPressed(_ sender: UIButton) {
        
    }
    
}


  //       let card1 = Card(shape: .circle, shading: .open, color: .purple, number: .one)
  //       let card2 = Card(shape: .triangle, shading: .open, color: .green, number: .two)
  //       let card3 = Card(shape: .square, shading: .open, color: .red, number: .three)
    //    lazy var selectedCards = [card1, card2,card3]
    
    /// compares
    // return an array of properties that they have in common
//    func compare(firstcard: Card,and secondCard: Card) -> [random]?  {
//        // holds the properties that are similar between the two cards
//        var propertiesThatAreSimilar: [random] = []
//        for (cp1) in (firstcard.properties) {
//            if (secondCard.contains(property: cp1)) { propertiesThatAreSimilar.append(cp1) }
//        }
//        // returns the array of properties
//        return (propertiesThatAreSimilar.isEmpty) ? nil : propertiesThatAreSimilar
//    }
//
//    func isASet() -> Bool {
//        var aSetHasBeenFound = false
//        // check if first two cards have a similarity
//        if let similarProperties = compare(firstcard: selectedCards[0], and: selectedCards[1]) {
//            // if they do then check if the properties they have in common are found in the thirdCard
//            similarProperties.forEach { property in
//                // if any of the similary properties are found in the third card, then it is a set.
//                if (selectedCards[2].contains(property: property)) {
//                  // if the the properties are found in the third card then it is a set
//                    aSetHasBeenFound = true
//                }
//            }
//            // if no similarity has been found, return false.
//            return (aSetHasBeenFound)
//        }
//        // if they dont
//        // Then check if cardTwo and CardOne have anything in common with cardThree
//        // if no similaries are found then they are a set.
//        return (compare(firstcard: selectedCards[0], and: selectedCards[2]) == nil && compare(firstcard: selectedCards[1], and: selectedCards[2]) == nil)
//     }

 




