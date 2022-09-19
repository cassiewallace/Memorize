//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/15/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var gameName: String
    private(set) var numberOfPairsOfCards: Int
    private(set) var color: String
    var score: Int = 0
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].wasAlreadySeen {
                    score -= 1
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                // We flip the cards of the previous pick, if they weren't a match.
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            if !cards[chosenIndex].wasAlreadySeen {
                cards[chosenIndex].wasAlreadySeen.toggle()
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
  
//  TODO: Implement func keepScore
    
    init(gameName: String, numberOfPairsOfCards: Int, color: String, cardTypes: [CardContent]) {
        self.gameName = gameName
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.color = color

        // Start initializing cards.
        cards = Array<Card>()
        for pairIndex in 0..<cardTypes.count {
            let content = cardTypes[pairIndex]
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
        // Done initializing cards.
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var wasAlreadySeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
