//
//  Cardify.swift
//  Memorize
//
//  Created by sana on 2021/06/26.
//

import SwiftUI


struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstantns.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstantns.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
        .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (0, 1, 0))
    }
    
    private struct DrawingConstantns {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
