//
//  SetCard.swift
//  Set
//
//  Created by sana on 2021/06/06.
//

import Foundation

enum SetCardNumber: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum SetCardColor: String, CaseIterable {
    case red, green, purple
}

enum SetCardShape: String, CaseIterable {
    case diamond, squiggle, oval
}

enum SetCardShade: String, CaseIterable {
    case solid, striped, open
}

enum SetCardSetState {
    case normal, unset, set
}

struct SetCard {
    var number: SetCardNumber
    var color: SetCardColor
    var shape: SetCardShape
    var shade: SetCardShade
    var isSelected = false
    var setState: SetCardSetState = .normal
}

extension SetCard: Identifiable {
    var id: String {
        return "\(self.number.rawValue)\(self.color.rawValue)\(self.shape.rawValue)\(self.shade.rawValue)"
    }
}

extension SetCard: Equatable {
    // 自身と同じ型を2つ受け取る静的メソッド
    static func == (lhs: SetCard, rhs: SetCard) -> Bool{
        return lhs.id == rhs.id
    }
}

extension SetCard {
    static var all: [SetCard] {
        var cards: [SetCard] = []
        SetCardNumber.allCases.forEach { number in
            SetCardColor.allCases.forEach { color in
                SetCardShape.allCases.forEach { shape in
                    SetCardShade.allCases.forEach { shade in
                        cards.append(SetCard(number: number, color: color, shape: shape, shade: shade))
                    }
                }
            }
        }
        return cards
    }
    
    static var random: SetCard {
        let number = SetCardNumber.allCases.randomElement()!
        let color = SetCardColor.allCases.randomElement()!
        let shape = SetCardShape.allCases.randomElement()!
        let shade = SetCardShade.allCases.randomElement()!
        
        return SetCard(number: number, color: color, shape: shape, shade: shade)
    }
}
