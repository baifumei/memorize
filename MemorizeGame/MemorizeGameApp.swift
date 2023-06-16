//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by Екатерина К on 18.08.2022.
//

import SwiftUI

@main
struct MemorizeGameApp: App {
    let game = EmojiMemoryGame(theme: EmojiMemoryGame.themes[1])
    
    var body: some Scene {
        WindowGroup {
            firstPageView(viewModel: game)
        }
    }
}
