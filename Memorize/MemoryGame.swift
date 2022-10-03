//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/15/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // MARK: - Private Var(s)
    private(set) var cards: Array<Card>
    private(set) var color: String
    private(set) var gameName: String
    private(set) var numberOfPairsOfCards: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter( { cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    // MARK: - Public Var(s)
    var currentScore = 0
    
    // MARK: - Enums(s)
    enum Action {
        case matched
        case wasAlreadySeen
    }
    
    // MARK: - Public Func(s)
    func calculateScore(_ action: Action, currentScore: Int) -> Int {
        var newScore = currentScore
        
        switch action {
            case .matched: newScore += 2
            case .wasAlreadySeen: newScore -= 1
        }
        
        return newScore
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    currentScore = calculateScore(.matched, currentScore: currentScore)
                } else if cards[chosenIndex].wasAlreadySeen {
                    currentScore = calculateScore(.wasAlreadySeen, currentScore: currentScore)
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            if !cards[chosenIndex].wasAlreadySeen {
                cards[chosenIndex].wasAlreadySeen.toggle()
            }
        }
    }
    
    // MARK: - Init(s)
    init(gameName: String, numberOfPairsOfCards: Int, color: String, cardTypes: [CardContent]) {
        self.gameName = gameName
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.color = color

        // Start initializing cards.
        cards = []
        for pairIndex in 0..<cardTypes.count {
            let content = cardTypes[pairIndex]
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
        // Done initializing cards.
    }
    
    // MARK: - Struct(s)
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var wasAlreadySeen = false
        let content: CardContent
        let id: Int
    }
}

// MARK: - Extension(s)
extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
