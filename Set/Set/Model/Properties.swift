//
//  Properties.swift
//  Set
//
//  Created by angel zambrano on 6/18/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation

protocol random {
    
}


class Properties {
   
    enum Number1: random {
        case one
        case two
        case three
    
        func getAll()->[Number1] {
            return [.one,.two,.three]
        }
    }
    
    enum Color1: random {
        case red
        case green
        case purple
        
        func getAll()->[Color1] {
            return [.red,.green,.purple]
        }
    }
    
    enum Shape1: random {
        case circle
        case square
        case triangle
        
        func getAll()->[Shape1] {
            return [.circle, .square, .triangle]
        }
    }
    
    enum Shading1: random {
        case solid
        case striped
        case open
        
        func getAll()->[Shading1] {
            return [.solid,.striped, .open ]
        }
    }
}
