//
//  Theme.swift
//  Memorize
//
//  Created by Cassie Wallace on 9/16/22.
//

import Foundation

private struct ThemeConstants {
    static let emojis: [Theme : [String]] = [
        .flags: ["🇧🇪", "🇬🇧", "🇨🇦", "🇹🇷", "🇧🇾", "🇧🇶", "🇨🇷", "🇨🇫", "🇧🇲", "🇨🇨", "🇨🇴", "🇨🇬", "🇨🇩", "🇨🇰", "🇨🇮", "🇭🇷", "🇨🇺", "🇨🇼", "🇨🇾", "🇨🇿", "🇩🇰", "🇩🇯", "🇫🇷", "🇲🇰", "🇬🇷"],
        .food: ["🥓", "🥦", "🍩", "🥗", "🍜", "🍰", "🌮", "🥘", "🥟", "🧁", "🍿", "🍤", "🍕", "🌭", "🍟", "🥬", "🥕", "🥐", "🍔", "🥨", "🍳", "🍎", "🥯", "🥖", "🌶"],
        .home: ["🪑", "🚽", "🛁", "✂️", "🖊", "🏡", "🪴", "🔨", "🛋", "🛏", "🖼", "🧺", "🪣", "🪠", "🧽", "🪞", "🚿", "📨", "🔑", "🚪", "🧻", "🪜", "📺", "🧯", "☎️"],
        .nature:  ["🍀", "🌲", "🌴", "🌵", "🌳", "🌿", "🐚", "🍁", "🪸", "🍄", "🪨", "🌷", "🌺", "🌻", "☀️", "🌈", "🌊", "❄️", "🌾", "🌱", "💨", "🌚", "🪷", "🎋", "💦"],
        .skiing: ["❄️", "⛷", "🎿", "🚡", "🚠", "🪵", "🌲", "🏔", "🌨", "☕️", "🍻", "⚠️", "🧦", "🏂", "🧤", "🧣", "🥇"],
        .sports: ["⚽️", "🏀", "🎾", "🏋️‍♀️", "🤼‍♀️", "🥋", "🤾‍♂️", "🏃‍♂️", "🏂", "🏊‍♀️", "🏅", "🧗‍♀️", "🚣", "🚵‍♀️", "⚾️", "🏃", "🤽‍♂️", "🏄‍♂️", "🏉", "🏓", "🥍", "🏏", "🏌️‍♂️", "🥊"]
    ]
    
    static let colors: [Theme : String] = [
        .flags : "red",
        .food: "orange",
        .nature: "green",
        .skiing: "blue",
        .sports: "yellow",
        .home: "brown"
    ]
    
}

enum Theme: String, CaseIterable {
    case flags = "Flags"
    case food = "Food"
    case nature = "Nature"
    case skiing = "Skiing"
    case sports = "Sports"
    case home = "Home"
    
    static func randomTheme() -> Theme {
        guard let themeName = Theme.allCases.randomElement() else {
        // fatalError("Theme enum should have at least 1 case.")
            return .flags
        }
        return themeName
    }
    
    func getThemeEmojis() -> [String] {
        return ThemeConstants.emojis[self] ?? []
    }
    
    func getThemeColor() -> String {
        return ThemeConstants.colors[self] ?? "black"
    }
    
    func maxThemeEmojisCount() -> Int {
        return getThemeEmojis().count
    }
}

struct GameTheme {
    let emojis: [String]
    let color: String
    
    private let themeName: Theme
    
    init() {
        self.init(Theme.randomTheme())
    }
    
    init(_ themeName: Theme) {
        self.themeName = themeName
        let numberOfPairsOfCards = Int.random(in: 4...self.themeName.maxThemeEmojisCount())
        self.emojis = Array(themeName.getThemeEmojis().shuffled()[0..<numberOfPairsOfCards])
        self.color = themeName.getThemeColor()
    }
    
    func displayName() -> String {
        return themeName.rawValue
    }
}
