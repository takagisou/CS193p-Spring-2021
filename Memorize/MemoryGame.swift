//
//  MemoryGame.swift
//  Memorize
//
//  Created by sana on 2021/05/31.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: [Card]
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairCards x 2 cards to cards array
        (0..<numberOfPairOfCards).forEach { index in
            let content = createCardContent(index)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
