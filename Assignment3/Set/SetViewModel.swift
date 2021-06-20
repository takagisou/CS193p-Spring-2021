//
//  SetViewModel.swift
//  Set
//
//  Created by sana on 2021/06/06.
//

import SwiftUI

class SetViewModel: ObservableObject {
    
    @Published var cards = SetCard.all.shuffled()
    
    func newGame() {
        cards = SetCard.all.shuffled()
        print("cards count: \(cards.count)")
        
    }
    
    func select(_ card: SetCard) {
        
        // update select state
        
        let newCards = cards.map { current -> SetCard in
            var c = current
            c.setState = .normal
            if current == card {
                c.isSelected = !current.isSelected
            }
            return c
        }

        let selectedCards = newCards.filter { $0.isSelected }
        if selectedCards.count != 3 {
            cards = newCards
            return
        }
        
        // check match
        let isSet = isSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2])
        
        let result = newCards.map { card -> SetCard in
            guard var setCard = selectedCards.first(where: {$0 == card}) else {
                return card
            }
            
            setCard.setState = isSet ? .set : .unset
            return setCard
        }
        
        cards = result
    }
    
    func isSet(card1: SetCard, card2: SetCard, card3: SetCard) -> Bool {
        return colorOk(card1: card1, card2: card2, card3: card3)
            && numberOk(card1: card1, card2: card2, card3: card3)
            && shapeOk(card1: card1, card2: card2, card3: card3)
            && shadeOk(card1: card1, card2: card2, card3: card3)
    }
    
    func colorOk(card1: SetCard, card2: SetCard, card3: SetCard) -> Bool {
        
        if card1.color == card2.color && card2.color == card3.color {
            return true
        }
        
        var dict: [SetCardColor: Bool] = SetCardColor.allCases.reduce(into: [SetCardColor: Bool]()) { $0[$1] = false }
        dict[card1.color] = true
        dict[card2.color] = true
        dict[card3.color] = true
        return !dict.values.contains(false)
    }
    
    func numberOk(card1: SetCard, card2: SetCard, card3: SetCard) -> Bool {
        if card1.number == card2.number && card2.number == card3.number {
            return true
        }
        
        var dict: [SetCardNumber: Bool] = SetCardNumber.allCases.reduce(into: [SetCardNumber: Bool]()) { $0[$1] = false }
        dict[card1.number] = true
        dict[card2.number] = true
        dict[card3.number] = true
        return !dict.values.contains(false)
    }
    
    func shapeOk(card1: SetCard, card2: SetCard, card3: SetCard) -> Bool {
        if card1.shape == card2.shape && card2.shape == card3.shape {
            return true
        }
        
        var dict: [SetCardShape: Bool] = SetCardShape.allCases.reduce(into: [SetCardShape: Bool]()) { $0[$1] = false }
        dict[card1.shape] = true
        dict[card2.shape] = true
        dict[card3.shape] = true
        return !dict.values.contains(false)
    }
    
    func shadeOk(card1: SetCard, card2: SetCard, card3: SetCard) -> Bool {
    
        if card1.shade == card2.shade && card2.shade == card3.shade {
            return true
        }
        
        var dict: [SetCardShade: Bool] = SetCardShade.allCases.reduce(into: [SetCardShade: Bool]()) { $0[$1] = false }
        dict[card1.shade] = true
        dict[card2.shade] = true
        dict[card3.shade] = true
        return !dict.values.contains(false)
    }
}
