//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by sana on 2021/05/28.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("\(game.title)").font(.title)
            Text("SCORE: \(game.score)").font(.headline)
            ScrollView {
                AspectVGrid(items: game.cards,
                            aspectRatio: 2/3,
                            content: { card in
                                CardView(card)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .onTapGesture {
                                        game.choose(card)
                                    }
                            })
            }
            .foregroundColor(.red)
            .padding(.horizontal)
            Button(action: {
                game.newGame()
            }, label: {
                Text("New Game").font(.title2)
            })
        }
    }
}


struct CardView: View {
    
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    @State
    var isFaceUp = true
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: DrawingConstantns.cornerRadius)
            ZStack {
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstantns.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * DrawingConstantns.fontScale)
    }
    
    private struct DrawingConstantns {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.dark)
        }
    }
}
