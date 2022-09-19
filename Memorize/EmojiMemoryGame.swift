//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/15/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // MARK: - Public Var(s)
    typealias Card = MemoryGame<String>.Card
    
    var cards: Array<Card> {
        return memoryGameModel.cards
    }
    
    var gameName: String {
        return memoryGameModel.gameName
    }
    
    var numberOfPairsOfCards: Int {
        return memoryGameModel.numberOfPairsOfCards
    }
    
    var color: Color {
        switch memoryGameModel.color {
            case "red": return .red
            case "orange": return .orange
            case "yellow": return .yellow
            case "green": return .green
            case "blue": return .blue
            case "purple": return .purple
            case "pink": return .pink
            case "brown": return .brown
            default: return .black
        }
    }
    
    var score: Int {
        return memoryGameModel.score
    }
    
    // MARK: - Private Var(s)
    @Published private var memoryGameModel: MemoryGame<String>
    
    // MARK: - Init(s)
    
    init() {
        memoryGameModel = Self.createMemoryGame()
    }
    
    // MARK: - Private Static Func(s)
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let themeModel = GameTheme()
        
        let gameName = themeModel.displayName()
        let emojis = themeModel.emojis
        let numberOfPairsOfCards = emojis.count
        let color = themeModel.color
        
        return MemoryGame<String>(gameName: gameName, numberOfPairsOfCards: numberOfPairsOfCards, color: color,
                                  cardTypes: emojis)
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        memoryGameModel.choose(card)
    }
    
    func startNewGame(){
        memoryGameModel = Self.createMemoryGame()
    }
}
