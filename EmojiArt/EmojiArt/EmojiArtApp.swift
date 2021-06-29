//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by sana on 2021/06/29.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
