//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Екатерина К on 09.09.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    let color = RadialGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor2")]), center: .center, startRadius: 20, endRadius: 100)
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth).fill(color).shadow(color: .black.opacity(0.4), radius: DrawingConstants.radius)
                content
            } else {
                shape.fill(color).shadow(color: .black.opacity(0.4), radius: DrawingConstants.radius)
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let radius: CGFloat = 2
    }
}
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
