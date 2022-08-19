//
//  ContentView.swift
//  MemorizeGame
//
//  Created by Екатерина К on 18.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                    }
                }.padding(5)
            }
        }.padding()
    }
}


struct CardView: View {
    
    let card: MemoryGame<String>.Card
    let color = RadialGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor2")]), center: .center, startRadius: 20, endRadius: 100)
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.foregroundColor(.white)
                shape.stroke(lineWidth: 3).fill(color).shadow(color: .black.opacity(0.4), radius: 2)
                Text(card.content)
                    .font(.largeTitle)
            } else {
                shape.fill(color).shadow(color: .black.opacity(0.4), radius: 2)
            }
        }
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
