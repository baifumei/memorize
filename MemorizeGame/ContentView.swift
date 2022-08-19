//
//  ContentView.swift
//  MemorizeGame
//
//  Created by Екатерина К on 18.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis = ["🍏", "🍐", "🍊", "🍋", "🍑", "🍈", "🥭", "🥥", "🍇", "🍒", "🍍", "🍎", "🍌"]
    @State var cardCount = 3
    
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<cardCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }.padding(5)
            }
            
            Spacer()
            
            HStack {
                remove
                Spacer()
                shuffle
                Spacer()
                add
            }
        }.padding()
    }
  
    
    
    var remove: some View {
        Button(action: {
            if cardCount > 1 {
                cardCount -= 1
            }
        }) {
            Image(systemName: "minus.circle.fill")
                .foregroundColor(Color("ButtonColor"))
        }
    }
    
    var add: some View {
        Button(action: {
            if cardCount < emojis.count {
                cardCount += 1
            }
        }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(Color("ButtonColor"))
        }
    }
    
    var shuffle: some View {
        Button(action: {
            emojis.shuffle()
        }) {
            Text("Shuffle").font(.title2).foregroundColor(Color("ButtonColor")).fontWeight(.bold)
        }
    }
}



struct CardView: View {
    
    @State var isFaceUp: Bool = true
    let color = RadialGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor2")]), center: .center, startRadius: 20, endRadius: 100)
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.foregroundColor(.white)
                shape.stroke(lineWidth: 3).fill(color).shadow(color: .black.opacity(0.4), radius: 2)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill(color).shadow(color: .black.opacity(0.4), radius: 2)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
