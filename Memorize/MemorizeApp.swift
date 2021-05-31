//
//  MemorizeApp.swift
//  Memorize
//
//  Created by sana on 2021/05/28.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
