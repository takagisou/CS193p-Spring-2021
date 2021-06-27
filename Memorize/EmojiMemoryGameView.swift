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
        AspectVGrid(items: game.cards,
                    aspectRatio: 2/3) { card in
            cardView(for: card)
        }
                    .foregroundColor(.red)
                    .padding(.horizontal)
        //        VStack {
        //            Text("\(game.title)").font(.title)
        //            Text("SCORE: \(game.score)").font(.headline)
        //            ScrollView {
        //                AspectVGrid(items: game.cards,
        //                            aspectRatio: 2/3,
        //                            content: { card in
        //                                CardView(card)
        //                                    .padding(4)
        //                                    .onTapGesture {
        //                                        game.choose(card)
        //                                    }
        //                            })
        //            }
        //            .foregroundColor(.red)
        //            .padding(.horizontal)
        //            Button(action: {
        //                game.newGame()
        //            }, label: {
        //                Text("New Game").font(.title2)
        //            })
        //        }
        //    }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
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
            ZStack {
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 300 - 90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: DrawingConstantns.fontSize))
//                    .font(font(in: geometry.size))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstantns.fontSize / DrawingConstantns.fontScale)
    }
    

    private struct DrawingConstantns {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return Group {
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.dark)
        }
    }
}
