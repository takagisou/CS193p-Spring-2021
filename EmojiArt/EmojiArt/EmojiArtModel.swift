//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by sana on 2021/06/30.
//

import Foundation

struct EmojiArtModel: Codable {
    
    var background: Background = .blank
    var emojis: [Emoji] = []
    
    private var uniqueEmojiId = 0
    
    struct Emoji: Identifiable, Hashable, Codable {
        let text: String
        var x: Int // offset from the center
        var y: Int // offset from the center
        var size: Int
        let id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    init() {}
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
    }
}
