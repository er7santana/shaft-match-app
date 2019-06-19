//
//  CardModel.swift
//  Shaft Match
//
//  Created by Rodrigo Sant Ana on 17/06/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        var cards = [Card]()
        var cardNumbersAdded = [Int]()
        
        while cards.count < 16 {
            
            let randomNumber = arc4random_uniform(13) + 1
            
            if !cardNumbersAdded.contains(Int(randomNumber)){
                for _ in 1...2 {
                    let card = Card()
                    card.imageName = "card\(randomNumber)"
                    cards.append(card)
                }
                cardNumbersAdded.append(Int(randomNumber))
                print(randomNumber)
            }
        }
        
        // Randomize the array
        for index in 0..<cards.count {
            
            let randomNumber = Int(arc4random_uniform(UInt32(cards.count - 1)))
            let temporaryStorage = cards[index]
            cards[index] = cards[randomNumber]
            cards[randomNumber] = temporaryStorage
        }
        return cards
    }
}
