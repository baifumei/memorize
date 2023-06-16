//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Екатерина К on 09.09.2022.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier { //взяли на себя всю анимацию
    var rotation: Double //in degrees
    let color = RadialGradient(gradient: Gradient(colors: [Color("CardColor"), Color("CardColor2")]), center: .center, startRadius: 40, endRadius: 100)
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double { //это про то какие данные мы хотим анимировать
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.foregroundColor(.white)
                shape.stroke(lineWidth: DrawingConstants.lineWidth).fill(color).shadow(color: .black.opacity(0.4), radius: DrawingConstants.radius)
                
            } else {
                shape.fill(color).shadow(color: .black.opacity(0.4), radius: DrawingConstants.radius)
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let radius: CGFloat = 2
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
