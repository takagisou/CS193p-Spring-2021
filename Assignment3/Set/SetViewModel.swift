//
//  SetViewModel.swift
//  Set
//
//  Created by sana on 2021/06/06.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published var cards = SetCard.all.shuffled()
    
    func select(_ card: SetCard) {
        cards = cards.map { current -> SetCard in
            if current == card {
                var c = current
                c.isSelected = !current.isSelected
                return c
            }
            return current
        }
    }
}
