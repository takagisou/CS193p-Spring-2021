//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by sana on 2021/05/31.
//

import SwiftUI

class EmojiMemoryGame {
    
    static let emojis = [
        "🚲", "🚂", "🚁", "🚜", "🚕", "🏎",
        "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️",
        "🛸", "🛶", "🚌", "🏍", "🛺", "🚠",
        "🛵", "🚗", "🚚", "🚇", "🛻", "🚝",
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairOfCards: 4) { index in
            emojis[index]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
