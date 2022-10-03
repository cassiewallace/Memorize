//
//  ContentView.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/13/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    gameBody
                    HStack {
                        shuffle
                        Spacer()
                        Text("Score: \(emojiMemoryGame.score)")
                        .padding(.horizontal)
                    }
                }
                deckBody
            }
            .padding(.horizontal)
            .navigationBarTitle("Memorize!", displayMode: .inline)
            .navigationBarItems(leading:
                Text(emojiMemoryGame.gameName)
            )
            .navigationBarItems(trailing:
                Button { withAnimation {
                    dealt = []
                    emojiMemoryGame.startNewGame()
                    }
                } label : {
                    Text("New Game")
                }
            )
        }
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = emojiMemoryGame.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (DrawingConstants.totalDealDuration / Double(emojiMemoryGame.cards.count))
        }
        return Animation.easeInOut(duration: DrawingConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(emojiMemoryGame.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: emojiMemoryGame.cards, aspectRatio: DrawingConstants.aspectRatio) { card in
                // I had to implement Group to avoid an issue with the if statements not being Views, which the instructor didn't encounter.
                Group {
                    if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                        Color.clear
                    } else {
                        Card(card: card, fillColor: emojiMemoryGame.color)
                            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                            .padding(DrawingConstants.cardPadding)
                            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                            .zIndex(zIndex(of: card))
                            .onTapGesture {
                                withAnimation {
                                    emojiMemoryGame.choose(card)
                                }
                            }
                    }
                }
        }
        .foregroundStyle(emojiMemoryGame.color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(emojiMemoryGame.cards.filter(isUndealt)) { card in
                Card(card: card, fillColor: emojiMemoryGame.color)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .zIndex(zIndex(of: card))
            }
        }
        .frame(width: DrawingConstants.undealtWidth, height: DrawingConstants.undealtHeight)
        .foregroundStyle(emojiMemoryGame.color)
        .onTapGesture {
            for card in emojiMemoryGame.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                emojiMemoryGame.shuffle()
            }
        }
    }
    
    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let cardPadding: CGFloat = 4
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        return EmojiMemoryGameView(emojiMemoryGame: game)
            .previewDevice("iPhone 13")
    }
}
