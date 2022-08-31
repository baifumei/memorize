//
//  EmojiMemoryGameView.swift
//  MemorizeGame
//
//  Created by Екатерина К on 18.08.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isMatched {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
    }
}



struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    let color = RadialGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor2")]), center: .center, startRadius: 20, endRadius: 100)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.stroke(lineWidth: DrawingConstants.lineWidth).fill(color).shadow(color: .black.opacity(0.4), radius: DrawingConstants.radius)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill(color).shadow(color: .black.opacity(0.4), radius: DrawingConstants.radius)
                }
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let radius: CGFloat = 2
        static let fontScale: CGFloat = 0.7
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
}
                       














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
