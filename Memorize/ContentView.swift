//
//  ContentView.swift
//  Memorize
//
//  Created by sana on 2021/05/28.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("\(viewModel.title)").font(.title)
            Text("SCORE: \(viewModel.score)").font(.headline)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game").font(.title2)
            })
        }
    }
}


struct CardView: View {
    
    let card: MemoryGame<String>.Card
    // extra: 2.3
    let color: Color?
    
    private var gradient: LinearGradient? {
        guard let color = color else {
            return nil
        }
        let start: UnitPoint = .init(x: 0, y: 1)
        let end: UnitPoint = .init(x: 1, y: 0)
        return LinearGradient(
            gradient: Gradient(colors: [color, .white]),
            startPoint: start,
            endPoint: end)
    }
    
    @State
    var isFaceUp = true
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp {
                // extra2.3
                // fill gradient color if color exists
                if let gradient = gradient {
                    shape.fill(gradient).foregroundColor(.white)
                } else {
                    shape.fill().foregroundColor(.white)
                }
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                // extra2.3
                // fill gradient color if color exists
                if let gradient = gradient {
                    shape.fill(gradient)
                } else {
                    shape.fill()
                }
            }
        }
    }
}

extension EmojiMemoryGame {
    var color: Color {
        switch self.colorName {
        case "red":
            return .red
        case "pink":
            return .pink
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "gray":
            return .gray
        case "green":
            return .green
        case "black":
            return .black
        case "purple":
            return .purple
        default:
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
        }
    }
}
