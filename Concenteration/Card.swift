//
//  Card.swift
//  Concenteration
//
//  Created by El-Shazly on 6/14/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation
struct Card: Hashable {

    static var identifierFactory = 1
    var identifier = 0
    var isFaced = false
    var isMatched = false
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    private static func getIdentifier(){
    identifierFactory+=1
    }
    init() {
        
        self.identifier = Card.identifierFactory
        Card.getIdentifier()
        
    }
    
    
    
    
    
}
