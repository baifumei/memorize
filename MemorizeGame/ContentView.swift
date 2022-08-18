//
//  ContentView.swift
//  MemorizeGame
//
//  Created by Екатерина К on 18.08.2022.
//

import SwiftUI

let color = RadialGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor2")]), center: .center, startRadius: 20, endRadius: 100)
let emoji = "🍏"

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
                .fill(color)
                .frame(width: 90, height: 120)
                .shadow(color: .black.opacity(0.4), radius: 2)
            Text(emoji)
                .font(.title)
        }
    }
}





 














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
