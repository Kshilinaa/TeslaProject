//
//  CustomTabBarPath.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 16.05.2024.
//

import SwiftUI
/// Форма для кастомного таббара
struct CustomTabBarPath: Shape {
    /// Функция, создающая путь для таббара
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let height = rect.height
        
        /// Левая нижняя точка
        path.move(to: CGPoint(x: rect.minX + 40, y: rect.maxY))
        /// Центр слева
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.midY - 5), control: CGPoint(x: 0, y: height - 15))
        /// Верхняя левая
        path.addQuadCurve(to: CGPoint(x: rect.minX + 55, y: rect.minY + 5), control: CGPoint(x: rect.minX - 5, y: rect.minY + 20))
        /// Левая точка у выемки сверху
        path.addQuadCurve(to: CGPoint(x: rect.midX - 50, y: rect.minY + 5), control: CGPoint(x: rect.midX - 70, y: rect.minY - 9))
        
        /// Правая точка у выемки сверху
        path.addQuadCurve(to: CGPoint(x: rect.midX + 50, y: rect.minY + 5), control: CGPoint(x: rect.midX, y: rect.minY + 55))
        /// Верхняя правая
        path.addQuadCurve(to: CGPoint(x: rect.maxX - 40, y: rect.minY + 5), control: CGPoint(x: rect.midX + 70, y: rect.minY - 9))
        /// Центр справа
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY - 5), control: CGPoint(x: rect.maxX + 5, y: rect.minY + 20))
        /// Правая нижняя точка
        path.addQuadCurve(to: CGPoint(x: rect.maxX - 40, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.maxY - 15))
        
        return path
    }
}

struct CustomTabBarPath_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarPath()
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 300, height: 100)
            .padding()
    }
}
