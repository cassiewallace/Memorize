//
//  ContentView.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: Array = ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"]
    @State var emojiCount: Int = 12
    
    @discardableResult func setTheme(theme: String) -> (emojis: Array<Any>, emojiCount: Int) {
        switch theme {
            case "flags":
                emojis = ["🇧🇪", "🇬🇧", "🇨🇦", "🇹🇷", "🇧🇾", "🇧🇶", "🇨🇷", "🇨🇫", "🇧🇲", "🇨🇨", "🇨🇴", "🇨🇬", "🇨🇩", "🇨🇰", "🇨🇮", "🇭🇷", "🇨🇺", "🇨🇼", "🇨🇾", "🇨🇿", "🇩🇰", "🇩🇯", "🇫🇷", "🇲🇰", "🇬🇷"]
                emojiCount = 16
            case "food":
                emojis = ["🥓", "🥦", "🍩", "🥗", "🍜", "🍰", "🌮", "🥘", "🥟", "🧁", "🍿", "🍤", "🍕", "🌭", "🍟", "🥬", "🥕", "🥐", "🍔", "🥨", "🍳", "🍎", "🥯", "🥖", "🌶"]
                emojiCount = 8
            case "nature":
                emojis = ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"]
                emojiCount = 12
            default:
                emojis = ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"]
                emojiCount = 12
        }

        return (emojis, emojiCount)
    }
    
    var body: some View {
        let shuffledEmojis = emojis.shuffled()
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.vertical)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 55))]) {
                    ForEach(shuffledEmojis[0..<emojiCount], id: \.self) { emoji in
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
            .padding(.vertical)
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
                
                
        }
    }
}
