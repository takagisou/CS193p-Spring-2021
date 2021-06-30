//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by sana on 2021/06/30.
//

import Foundation

extension EmojiArtModel {
    
    enum Background: Equatable {
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
    }
}
