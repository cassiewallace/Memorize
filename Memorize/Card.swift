//
//  Card.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/20/22.
//

import SwiftUI

struct Card: View {
    let card: EmojiMemoryGame.Card
    let fillColor: Color
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(DrawingConstants.timerPadding)
                .opacity(DrawingConstants.timerOpacity)
                Text(card.content)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                }
                .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched, fillColor: fillColor)
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
        static let timerPadding: CGFloat = 4
        static let timerOpacity: CGFloat = 0.5
    }
}
