//
//  ContentView.swift
//  Set
//
//  Created by sana on 2021/06/04.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
            }.padding(.horizontal)
            let cards = viewModel.deck
            let items = (0..<12).map { index in cards[index] }
            AspectVGrid(items: items,
                        aspectRatio: 2/3) { card in
                CardView(card).onTapGesture {
                    print("tap: \(card.id)")
                    viewModel.select(card)
                }
            }
            .padding(.horizontal)
            HStack {
                Button("Change Card") {
                    //
                }.disabled(viewModel.hasSet)
                Button("Draw Extra") {
                    viewModel.newGame()
                }.disabled(!viewModel.canSet)
            }
        }
    }
}


struct CardView: View {
    
    private let card: SetCard
    
    init(_ card: SetCard) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            VStack {
                ForEach((0..<card.number.rawValue)) { num in
                    UICardShape(card)
                }
            }.padding()
            RoundedRectangle(cornerRadius: 10) .strokeBorder(card.uiBorderColor, lineWidth: 2.0)
        }.padding(5)
    }
    
    private enum Const {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct UICardShape: View {
    var card: SetCard
    
    init(_ card: SetCard) {
        self.card = card
    }
    
    var body: some View {
        Group {
            switch card.shape {
            case .diamond:
                Diamond()
                    .stroke(card.uiColor, lineWidth: 1.0)
                    .overlay(
                        Diamond()
                            .fill(card.uiColor)
                            .opacity(card.uiOpacity)
                    )
            case .oval:
                Oval()
                    .stroke(card.uiColor, lineWidth: 1.0)
                    .overlay(
                        Oval()
                            .fill(card.uiColor)
                            .opacity(card.uiOpacity)
                    )
            case .squiggle:
                Squiggle()
                    .stroke(card.uiColor, lineWidth: 1.0)
                    .overlay(
                        Squiggle()
                            .fill(card.uiColor)
                            .opacity(card.uiOpacity)
                    )
            }
        }
    }
}

extension SetCard {
    var uiColor: Color {
        switch self.color {
        case .green:
            return .green
        case .purple:
            return .purple
        case .red:
            return .red
        }
    }
    
    var uiOpacity: Double {
        switch  self.shade {
        case .open:
            return 1
        case .solid:
            return 0
        case .striped:
            return 0.3
        }
    }
    
    var uiBorderColor: Color {
        switch self.setState {
        case .normal:
            return self.isSelected ? .black : .gray.opacity(0.3)
        case .unset:
            return .red
        case .set:
            return .green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetViewModel()
        ContentView(viewModel: viewModel)
    }
}
