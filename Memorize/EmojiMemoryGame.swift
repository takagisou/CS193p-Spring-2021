//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by sana on 2021/05/31.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static func createMemoryGame(theme: MemoryGameTheme = MemoryGameTheme(theme: .vehicles)) -> MemoryGame<String> {
//        MemoryGame<String>(numberOfPairOfCards: theme.pairCount) { index in
//            theme.emojis[index]
//        }
        
        // extra2.1
        MemoryGame<String>(numberOfPairOfCards: theme.pairCount) { index in
            theme.emojis[index]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var theme: MemoryGameTheme = MemoryGameTheme(theme: .vehicles)
    
    var title: String {
        return theme.title
    }
    
    var score: Int {
        return model.points
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let theme = MemoryGameTheme.Theme.allCases.randomElement()!
//        self.theme = MemoryGameTheme(theme: theme)
        // extra2.2
        self.theme = MemoryGameTheme.withRandomPairCount(theme: theme)
        model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
}
