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

struct SetCard: Identifiable {
    var number: SetCardNumber
    var color: SetCardColor
    var shape: SetCardShape
    var shade: SetCardShade
    private var isSelected = false
    
    var id: String {
        return "\(self.number.rawValue)\(self.color.rawValue)\(self.shape.rawValue)\(self.shade.rawValue)"
    }
}

extension SetCard {
    static var random: SetCard {
        let number = SetCardNumber.allCases.randomElement()!
        let color = SetCardColor.allCases.randomElement()!
        let shape = SetCardShape.allCases.randomElement()!
        let shade = SetCardShade.allCases.randomElement()!
        
        return SetCard(number: number, color: color, shape: shape, shade: shade)
    }
}
