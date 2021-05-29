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
    var emojiCount = 6
    
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                    CardView(content: emoji)
                })
            }
            Spacer(minLength: 20)
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
    
    var remove: some View {
        Button(action: {
            if 1 < emojiCount {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
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
                shape.stroke(lineWidth: 3)
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
