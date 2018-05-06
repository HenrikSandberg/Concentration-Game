//
//  Card.swift
//  Concentration Game
//
//  Created by Henrik Anthony Odden Sandberg on 12.04.2018.
//  Copyright © 2018 Henrik Anthony Odden Sandberg. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    private let identifier: Int
    
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
