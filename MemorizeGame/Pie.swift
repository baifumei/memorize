//
//  Pie.swift
//  MemorizeGame
//
//  Created by Екатерина К on 31.08.2022.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatableData(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    
    
    func path(in rect: CGRect) -> Path { //path - контур, форма, а Path - контур 2д фигуры
        
        let center = CGPoint(x: rect.midX, y: rect.midY) //центр rect
        let radius = min(rect.width, rect.height) / 2 // из 2 величин выбрали наименьшую
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        ) //отправная точка
        var p = Path()
        p.move(to: center) //0:0
        p.addLine(to: start) //x=0, y=точка (высшая радиуса)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        ) //добывить дугу
        p.addLine(to: center)
        return p
    }
    
    
}
