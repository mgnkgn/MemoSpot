//
//  Shapes.swift
//  MemoSpotter
//
//  Created by Mehmet Güneş Akgün on 26.07.2024.
//

import Foundation
import SwiftUI


struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()


        path.move(to: CGPoint(x: rect.minX + 30, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - 30, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 30, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))




        return path
    }
}

struct Stick: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()


        path.move(to: CGPoint(x: rect.midX - 10, y: rect.maxY + 20))
        path.addLine(to: CGPoint(x: rect.midX + 10, y: rect.maxY + 20))
        path.addLine(to: CGPoint(x: rect.midX + 10, y: rect.minY + 70))
        path.addLine(to: CGPoint(x: rect.midX - 10, y: rect.minY + 90))
        path.addLine(to: CGPoint(x: rect.midX - 10, y: rect.maxY))
        




        return path
    }
}
