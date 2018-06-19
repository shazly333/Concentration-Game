//
//  Concentration.swift
//  Concenteration
//
//  Created by El-Shazly on 6/14/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation
import GameplayKit

class Concentration{
   private(set) var cards = [Card]()
   private var indexOfOnlyOneFacedUpCard: Int?{
        get{
            return cards.indices.filter { cards[$0].isFaced }.oneAndOnly
//            var foundIndex:Int?
//            for index in cards.indices{
//                if cards[index].isFaced{
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }
//                    else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaced = (index==newValue)
                print(index.arc4Random)
            }
        }
        
        
        
    }
    
    
    func choosenCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOnlyOneFacedUpCard, index != matchIndex{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaced = true
            }
            else{
                indexOfOnlyOneFacedUpCard = index
            }
        }
        
    }
    init(numberOfPairsOfCards:Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let newCard = Card()
            cards+=[newCard, newCard]
            
        }
        cards = shuffle(suffledArray: cards)
    }
    
    
    func shuffle(suffledArray array: [Card])->[Card] {
        let shuffled =  GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array)
        return shuffled as! [Card]
    }
    
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

