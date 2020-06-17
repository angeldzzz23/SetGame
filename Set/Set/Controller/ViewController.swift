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
        
        set.dealCard()
        
    }
}



extension Array {
    
// create a function that returns a collection that is cut
    
//    mutating func insertAndDelete(contentsOf: T) {
//
//    }
    
    
}
