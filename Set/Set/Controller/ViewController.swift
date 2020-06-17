//
//  ViewController.swift
//  Set
//
//  Created by angel zambrano on 6/16/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    lazy var set =  Set()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set.createAFullDeck()        
        print(set.cards.count)
        
        
        // Do any additional setup after loading the view.
        print("hello world")
    }


}

