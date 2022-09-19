//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/13/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(emojiMemoryGame: game)
        }
    }
}
