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
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2 + 1))
        }
    }
    
    mutating func choose(_ card: Card) {
        let index = index(of: card)
        cards[index].isFaceUp.toggle()
        print(cards)
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // bogus!
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
