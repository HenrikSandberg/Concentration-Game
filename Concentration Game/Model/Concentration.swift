//
//  Concentration.swift
//  Concentration Game
//
//  Created by Henrik Anthony Odden Sandberg on 12.04.2018.
//  Copyright © 2018 Henrik Anthony Odden Sandberg. All rights reserved.
//

import Foundation

struct Concentration{
    //MARK: - Variables
    private(set) var cards = [Card]()
   
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter{ cards[$0].isFaceUp}.oneAndOnly
        } set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //MARK:- Private API
    private mutating func randumize(){
        var cardsLookLike = [Card]()
        
        while cards.count > 0 {
            let selectRandumCard = cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
            cardsLookLike.append(selectRandumCard)
        }
        
        cards = cardsLookLike
    }
    
    //MARK: - Public API
    //This has to be public
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chose index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                //Check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
    }
    
    var isGameOver: Bool{
        get{
            var count = 0
            
            for card in cards {
                count = card.isMatched ? count + 1 : count
            }
            
            return count == cards.count
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 0 ..< numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        randumize()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}















