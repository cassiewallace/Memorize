//
//  ContentView.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/13/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 90 - 10 * (CGFloat(viewModel.numberOfPairsOfCards)/4)))]) {
                        ForEach(viewModel.cards) {
                            card in CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture{
                                    viewModel.choose(card)
                                }
                        }
                    }
                }
                .foregroundColor(viewModel.color)
                Text("Score: \(viewModel.score)")
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .navigationBarTitle("Memorize!", displayMode: .inline)
            .navigationBarItems(leading:
                Text(viewModel.gameName)
            )
            .navigationBarItems(trailing:
                Button {
                    viewModel.startNewGame()
                } label : {
                    Text("New Game")
                }
            )
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).padding(5)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
                .previewDevice("iPhone 13")
        }
    }
}
