//
//  MemoryGame.swift
//  Memorize
//
//  Created by sana on 2021/05/31.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    enum Theme {
        case vehicles
        
        var color: Color {
            return .red
        }
        
        var name: String {
            return "Vehicles"
        }
        
        var emojis: [String] {
            return [
                "🚲", "🚂", "🚁", "🚜", "🚕", "🏎",
                "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️",
                "🛸", "🛶", "🚌", "🏍", "🛺", "🚠",
                "🛵", "🚗", "🚚", "🚇", "🛻", "🚝",
            ]
        }
        
        var pairCount: Int {
            return 4
        }
    }
    
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else {
            return
        }
        
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp.toggle()        
    }
    
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairCards x 2 cards to cards array
        (0..<numberOfPairOfCards).forEach { index in
            let content = createCardContent(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
