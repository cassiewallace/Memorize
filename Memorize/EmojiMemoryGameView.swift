//
//  ContentView.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/13/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack {
                AspectVGrid(items: emojiMemoryGame.cards, aspectRatio: DrawingConstants.aspectRatio) { card in
                    Card(card: card, fillColor: emojiMemoryGame.color)
                        .padding(DrawingConstants.cardPadding)
                        .onTapGesture{
                            emojiMemoryGame.choose(card)
                        }
                    }
                    .foregroundStyle(emojiMemoryGame.color)
                Text("Score: \(emojiMemoryGame.score)")
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .navigationBarTitle("Memorize!", displayMode: .inline)
            .navigationBarItems(leading:
                Text(emojiMemoryGame.gameName)
            )
            .navigationBarItems(trailing:
                Button {
                    emojiMemoryGame.startNewGame()
                } label : {
                    Text("New Game")
                }
            )
        }
    }
    
    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let cardPadding: CGFloat = 4
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        // game.choose(game.cards.first!)
        return EmojiMemoryGameView(emojiMemoryGame: game)
            .previewDevice("iPhone 13")
    }
}
