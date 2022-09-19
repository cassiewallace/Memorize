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
                    CardView(card: card, fillColor: emojiMemoryGame.color)
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

// TODO: Move CardView to its own file.
struct CardView: View {
    let card: EmojiMemoryGame.Card
    let fillColor: Color
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20))
                        .padding(DrawingConstants.timerPadding)
                        .opacity(DrawingConstants.timerOpacity)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    if #available(iOS 16.0, *) {
                        shape.fill(fillColor.gradient)
                    } else {
                        shape.fill()
                    }
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let timerPadding: CGFloat = 4
        static let timerOpacity: CGFloat = 0.5
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
