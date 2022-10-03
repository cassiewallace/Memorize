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
