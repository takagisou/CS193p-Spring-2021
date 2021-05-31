//
//  ContentView.swift
//  Memorize
//
//  Created by sana on 2021/05/28.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = [
        "🚲", "🚂", "🚁", "🚜", "🚕", "🏎",
        "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️",
        "🛸", "🛶", "🚌", "🏍", "🛺", "🚠",
        "🛵", "🚗", "🚚", "🚇", "🛻", "🚝",
    ]
    
    @State
    var emojiCount = 20
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
        
}


struct CardView: View {
    var content: String
    
    @State
    var isFaceUp = true
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
