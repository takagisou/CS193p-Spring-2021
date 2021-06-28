//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by sana on 2021/05/28.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    @State private var dealt = Set<Int>()
    
    var body: some View {
        VStack{
            gameBody
            deckBody
            shuffle
        }
        .padding()
        
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
    
    var gameBody: some View {
        AspectVGrid(items: game.cards,
                    aspectRatio: 2/3) { card in
            cardView(for: card)
        }
                    .foregroundColor(CardConstants.color)
        
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card)
                    .transition(.asymmetric(insertion: .opacity, removal: .scale))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {            
            withAnimation(.easeInOut(duration: 5)) {
                // "deal" cards
                for card in game.cards {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            game.shuffle()
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) || card.isMatched && !card.isFaceUp {
            Color.clear
        } else {
            CardView(card)
                .padding(4)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
    }
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private struct CardConstants {
        static let color: Color = .red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
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
