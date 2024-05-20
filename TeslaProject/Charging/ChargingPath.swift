//
//  ChargingPath.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 18.05.2024.
//
import SwiftUI
/// Форма для отображения иконки зарядки
struct ChargingPath: Shape {
    /// Функция, создающая путь для иконки зарядки
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let margin: CGFloat = 10
        
        return Path { path in
            /// Левая нижняя точка
            path.move(to: CGPoint(x: 0, y: height))
            /// Центр слева
            path.addLine(to: CGPoint(x: 0, y: height / 2))
            /// Верхняя левая точка
            path.addLine(to: CGPoint(x: margin, y: 0))
            /// Верхняя правая точка
            path.addLine(to: CGPoint(x: width - margin, y: 0))
            /// Центр справа
            path.addLine(to: CGPoint(x: width, y: height / 2))
            /// Правая нижняя точка
            path.addLine(to: CGPoint(x: width, y: height))
            /// Замыкает путь
            path.closeSubpath()
        }
    }
}

#Preview {
    ChargingPath()
}


