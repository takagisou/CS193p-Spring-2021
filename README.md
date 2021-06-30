# CS193P Spring 2021

https://www.youtube.com/playlist?list=PLpGHT1n4-mAsxuRxVPv7kj4-dQYoC3VVu

# Homework
https://cs193p.sites.stanford.edu/

# Lecture 2

4 emojis

```swift
var emojis = ["🚗","🚕","🚙", "🚌"]
```

24 vehicales

```swift
var emojis = [
    "🚲", "🚂", "🚁", "🚜", "🚕", "🏎",
    "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️",
    "🛸", "🛶", "🚌", "🏍", "🛺", "🚠",
    "🛵", "🚗", "🚚", "🚇", "🛻", "🚝",
]
```

# Lecture 11

```swift
// EmojiArt > PaletteStore.swift

func palette(at index: Int) -> Palette {
    let safeIndex = min(max(index, 0), palettes.count - 1) // <- smart
    return palettes[safeIndex]
}
```