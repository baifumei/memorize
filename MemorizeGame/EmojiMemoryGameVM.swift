//
//  EmojiMemoryGameVM.swift
//  MemorizeGame
//
//  Created by Екатерина К on 19.08.2022.
//ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static var animals = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐼", "🐯", "🦁"].shuffled()
    static var fruits = ["🍏", "🍇", "🍐", "🍋", "🍊", "🍑", "🥭", "🥥"].shuffled()
    static var balls = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏐", "🏉"].shuffled()
    static var hearts = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍"].shuffled()
    static var weather = ["⛅️", "❄️", "🌈", "💨", "☔️", "☀️", "🌩️", "🌤️"].shuffled()
    
    typealias Theme = MemoryGame<String>.Theme
    typealias Card = MemoryGame<String>.Card
    
    
    static func createTheme(_ name: String, _ emojis: [String]) -> Theme {
        return Theme(name: name, emojis: emojis)
    }
    
    static var themes: [Theme] {
        var themes = [MemoryGame<String>.Theme]()
        themes.append(createTheme("Animals", animals))
        themes.append(createTheme("Balls", balls))
        themes.append(createTheme("Fruits", fruits))
        themes.append(createTheme("Hearts", hearts))
        themes.append(createTheme("Weather", weather))
        return themes
    }
    
    static func createMemoryGame(of chosenTheme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            chosenTheme.emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    @Published var chosenTheme: Theme

    init(theme: Theme) {
            chosenTheme = theme
            model = EmojiMemoryGame.createMemoryGame(of: theme)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    //MARK: Intent(s) //намерения
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(of: chosenTheme)
    }
}
