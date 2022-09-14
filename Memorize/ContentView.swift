//
//  ContentView.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: Array = ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"]
    @State var numberOfCards: Int = 12
    @State var cardWidth: CGFloat = 65
    
    func setTheme(theme: String) {
        numberOfCards = Int.random(in: 4...24)
        cardWidth = 60 + (24 - CGFloat(numberOfCards))/6 * 10
        
        switch theme {
            case "flags":
                emojis = ["🇧🇪", "🇬🇧", "🇨🇦", "🇹🇷", "🇧🇾", "🇧🇶", "🇨🇷", "🇨🇫", "🇧🇲", "🇨🇨", "🇨🇴", "🇨🇬", "🇨🇩", "🇨🇰", "🇨🇮", "🇭🇷", "🇨🇺", "🇨🇼", "🇨🇾", "🇨🇿", "🇩🇰", "🇩🇯", "🇫🇷", "🇲🇰", "🇬🇷"]
            case "food":
                emojis = ["🥓", "🥦", "🍩", "🥗", "🍜", "🍰", "🌮", "🥘", "🥟", "🧁", "🍿", "🍤", "🍕", "🌭", "🍟", "🥬", "🥕", "🥐", "🍔", "🥨", "🍳", "🍎", "🥯", "🥖", "🌶"]
            case "nature":
                emojis = ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"]
            default:
                emojis = ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"]
        }
    }
    
//    func
    
    var body: some View {
        let shuffledEmojis = emojis.shuffled()
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth))]) {
                    ForEach(shuffledEmojis[0..<numberOfCards], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.black)
            HStack {
                ButtonView(action: {self.setTheme(theme: "nature")}, labelImage: "leaf", labelText: "Nature")
                ButtonView(action: {self.setTheme(theme: "food")}, labelImage: "fork.knife", labelText: "Food")
                ButtonView(action: {self.setTheme(theme: "flags")},labelImage: "flag", labelText: "Flags")
            }
        }
        .padding(.horizontal)
    }
}

struct ButtonView: View {
    
    var action: () -> Void
    var labelImage: String
    var labelText: String

    var body: some View {
        Button {
            self.action()
        } label: {
            VStack {
                Image(systemName: labelImage)
                    .font(.largeTitle)
                    .frame(alignment: .top)
                    .padding(.vertical, 3.0)
                Text(labelText)
                    .font(.caption)
                    .frame(width:50)
            }
                    .frame(height: 60)
        }
        .buttonBorderShape(.roundedRectangle(radius: 12))
        .buttonStyle(.bordered)
        .padding(.all, 1.0)
        }
    }

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
                .previewInterfaceOrientation(.portrait)
                
                
        }
    }
}
