//
//  EmojiMemoryGameVM.swift
//  MemorizeGame
//
//  Created by Екатерина К on 19.08.2022.
//ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["🍏", "🍐", "🍊", "🍋", "🍑", "🍈", "🥭", "🥥", "🍇", "🍒", "🍍", "🍎", "🍌"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
