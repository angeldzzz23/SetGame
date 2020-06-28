//
//  Properties.swift
//  Set
//
//  Created by angel zambrano on 6/18/20.
//  Copyright © 2020 angel zambrano. All rights reserved.
//

import Foundation

protocol Property {
    
}   
    enum Number: Property {
        case one
        case two
        case three
    
        func getAll()->[Number] {
            return [.one,.two,.three]
        }
    }
    
    enum Color: Property {
        case red
        case green
        case purple
        
        func getAll()->[Color] {
            return [.red,.green,.purple]
        }
    }
    
    enum Shape: Property {
        case circle
        case square
        case triangle
        
        func getAll()->[Shape] {
            return [.circle, .square, .triangle]
        }
    }
    
    enum Shading: Property {
        case solid
        case striped
        case open
        
        func getAll()->[Shading] {
            return [.solid,.striped, .open ]
        }
    }

