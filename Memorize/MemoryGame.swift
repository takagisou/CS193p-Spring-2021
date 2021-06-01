//
//  MemoryGame.swift
//  Memorize
//
//  Created by sana on 2021/05/31.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private var chosenIndexes: Set<Int> = []
    private(set) var points = 0
    private(set) var cards: [Card]
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // extra: 2.4
    private var lastChosenDate: Date?
    private var earnPoints: Int {
        guard let date = lastChosenDate else {
            return 2
        }
        let interval = Date().timeIntervalSince(date)
        let points = max(Int(10 - interval), 2)
        
        print("interval: \(interval), earn points: \(points)")
        return points
    }
    
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
                
                // add points
                let addedPoints = earnPoints
                points += addedPoints
                print("add \(addedPoints) points, points: \(points)")
            } else {
                // mismatch
                if chosenIndexes.contains(chosenIndex) {
                    // penalty
                    points -= 1
                    print("penalty -1 point, points: \(points)")
                }
                
            }
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        
        cards[chosenIndex].isFaceUp.toggle()
        chosenIndexes.insert(chosenIndex)
        
        // extra:2.4
        let now = Date()
        lastChosenDate = now
        print("add index: \(chosenIndex), current indexes: \(chosenIndexes), lastChosenData: \(now)")
    }
    
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        chosenIndexes = []
        cards = []
        points = 0
        // add numberOfPairCards x 2 cards to cards array
        (0..<numberOfPairOfCards).forEach { index in
            let content = createCardContent(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2 + 1))
        }
//        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
