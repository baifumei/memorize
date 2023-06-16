//
//  EmojiMemoryGameView.swift
//  MemorizeGame
//
//  Created by Екатерина К on 18.08.2022.
//

import SwiftUI

struct firstPageView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            List(EmojiMemoryGame.themes, id: \.name) { theme in
                NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))) {
                    VStack(alignment: .leading) {
                        Text(theme.name).font(.title3)
                        Text(theme.emojis.shuffled().joined())
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Memorize")
        }
    }
}


struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom ) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }.padding(.horizontal)
            }.padding(.horizontal)
            deckBody
        }
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0 //задержка между раздачей карт
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstant.totalDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstant.dealDuration).delay(delay)
    }
    
    private func zIndex(of  card: EmojiMemoryGame.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: CardConstant.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
//        .foregroundColor(Color("CardColor2"))
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt )) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstant.deckWidth, height: CardConstant.deckHeight)
        .onTapGesture {
            // "deal" cards
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
//        .foregroundColor(Color("CardColor2"))
    }
    
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                viewModel.restart()
            }
        }
    }
    
    private struct CardConstant {
        static let aspectRatio: CGFloat = 2/3
        static let fontScale: Double = 0.7
        static let fontSize: CGFloat = 32
        static let deckHeight: CGFloat = 90
        static let deckWidth = deckHeight * aspectRatio
        static let dealDuration: Double = 0.5
        static let totalDuration: Double = 2
    }
}
    
    

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    @State private var animatedBonusRemining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1 - animatedBonusRemining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                        
                    }
                }
                .padding(5)
                .foregroundColor(Color("CardColor2"))
                .opacity(DrawingConstants.pieOpacity)
                
                Text(card.cardContent)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    
    private struct DrawingConstants {
        static let pieOpacity: Double = 0.5
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }

}
                       














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: EmojiMemoryGame.themes[1])
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
