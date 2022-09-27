//
//  Cardify.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/22/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isMatched: Bool
    let fillColor: Color
    
    init(isFaceUp: Bool, isMatched: Bool, fillColor: Color) {
        rotation = isFaceUp ? 0 : 180
        self.isMatched = isMatched
        self.fillColor = fillColor
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
         ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 { // used to be if isFaceUp
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                } else if isMatched {
                shape.opacity(0)
            }
            else {
                if #available(iOS 16.0, *) {
                    shape.fill(fillColor.gradient)
                } else {
                    shape.fill()
                }
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let timerPadding: CGFloat = 4
        static let timerOpacity: CGFloat = 0.5
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool, fillColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched, fillColor: fillColor))
    }
}
 
