//
//  TeslaLogoView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 14.05.2024.
//
import SwiftUI
///Отрисовка верхней части логотипа
struct TopLogoTesla: Shape {
    /// Функция, создающая путь для верхней части логотипа
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topY: CGFloat = 115
        let controlY: CGFloat = 83
        let middleX: CGFloat = rect.midX
        let curveWidth: CGFloat = 35
        let curveHeight: CGFloat = 20
        /// Начальная точка левой кривой
        path.move(to: CGPoint(x: rect.minX + curveWidth, y: topY))
        /// Кривая к правой точке
        path.addQuadCurve(to: CGPoint(x: rect.maxX - curveWidth, y: topY), control: CGPoint(x: middleX, y: controlY))
        /// Линия к правой точке кривой
        path.addLine(to: CGPoint(x: rect.maxX - curveWidth - 15, y: topY + curveHeight))
        /// Кривая к левой точке кривой
        path.addQuadCurve(to: CGPoint(x: rect.minX + curveWidth + 15, y: topY + curveHeight), control: CGPoint(x: middleX, y: topY))
        /// Замыкает путь
        path.closeSubpath()
        
        return path
    }
}
/// Отрисовка нижней части логотипа
struct BottomLogoTesla: Shape {
    /// Функция, создающая путь для нижней части логотипа
    func path(in rect: CGRect) -> Path {
        var path = Path()
        /// Правая нижняя точка логотипа
        path.move(to: CGPoint(x: rect.maxX - 60, y: 170))
        /// Правая часть кривой
        path.addCurve(to: CGPoint(x: rect.midX + 30, y: 160),
                      control1: CGPoint(x: rect.maxX - (rect.maxX + 40) / 4, y: 160),
                      control2: CGPoint(x: rect.maxX - (rect.maxX + 40) / 4, y: 160))
        ///Выемка
        path.addLine(to: CGPoint(x: rect.midX, y: 195))
        ///Левая верхняя часть логотипа
        path.addLine(to: CGPoint(x: rect.midX - 30, y: 160))
        path.addCurve(to: CGPoint(x: rect.minX + 60, y: 170),
                      control1: CGPoint(x: rect.midX - 160, y: 160),
                      control2: CGPoint(x: rect.midX - 135, y: 180))
        /// Левая кривая к верхней части логотипа
        path.addCurve(to: CGPoint(x: rect.minX + 80, y: 195),
                      control1: CGPoint(x: rect.minX + 75, y: 210),
                      control2: CGPoint(x: rect.minX + 79, y: 200))
        ///Левая часть основания
        path.addCurve(to: CGPoint(x: rect.midX - 30, y: 185),
                      control1: CGPoint(x: rect.minX + 79, y: 200),
                      control2: CGPoint(x: rect.minX + 79, y: 180))
        ///Длина вершины треугольника
        path.addLine(to: CGPoint(x: rect.midX, y: 350))
        /// Правая верхняя часть логотипа
        path.addLine(to: CGPoint(x: rect.midX + 30, y: 185))
        path.addCurve(to: CGPoint(x: rect.maxX - 80, y: 195),
                      control1: CGPoint(x: rect.midX + 30, y: 185),
                      control2: CGPoint(x: rect.maxX - 70, y: 182))
        /// Правая кривая к нижней части логотипа
        path.addCurve(to: CGPoint(x: rect.maxX - 60, y: 170),
                      control1: CGPoint(x: rect.maxX - 75, y: 200),
                      control2: CGPoint(x: rect.maxX - 75, y: 200))
        
        return path
    }
}

struct TeslaLogoView_Previews: PreviewProvider {
    static var previews: some View {
        TopLogoTesla()
    }
}
