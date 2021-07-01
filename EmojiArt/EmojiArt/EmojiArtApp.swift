//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by sana on 2021/06/29.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    @StateObject var document = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
                .environmentObject(paletteStore)
        }
    }
}
