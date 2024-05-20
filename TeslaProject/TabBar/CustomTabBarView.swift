//
//  CustomTabBar.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 16.05.2024.
//

import SwiftUI
/// Структура, представляющая элемент вкладки с идентификатором и иконкой
struct CustomTabItem: Identifiable, Equatable {
    /// id
    var id = UUID()
    /// иконка
    var icon: String
}
/// Кастомизированное представление для вкладок
struct CustomTabView<Content: View>: View {
    /// Состояние для отслеживания выбранной вкладки
    @Binding var selection: Int
    @Namespace private var tabBarItem
    /// Массив элементов вкладок
    private var tabs: [CustomTabItem] = [
        .init(icon: "carIcon"),
        .init(icon: "flash"),
        .init(icon: "antenna"),
        .init(icon: "profile")
    ]
    /// Контент, отображаемый внутри вкладок
    private var content: Content
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            VStack(spacing: -15) {
                tabsView
            }
        }
    }
    
    init(selection: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selection = selection
    }
    // MARK: - Visual Components
    private var tabsView: some View {
        ZStack {
            CustomTabBarPath()
                .fill(.black)
                .shadow(color: .gray, radius: 2)
                .applyTabBarShadowStyle()
            HStack(spacing: 40) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
                    Image(element.icon)
                        .renderingMode(.template)
                        .foregroundColor(selection == index ? .blue : .white)
                        .frame(width: 40, height: 40)
                        .background(
                            ZStack {
                                if selection == index {
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .fill(
                                            .blue.opacity(0.6)
                                        )
                                        .frame(width: 45, height: 45)
                                        .matchedGeometryEffect(id: "tabBarItem", in: tabBarItem)
                                        .shadow(color: .blue.opacity(0.8), radius: 10, x: 0, y: 0)
                                        .transition(.scale)
                                }
                            }
                                .shadow(color: .blue, radius: 5, x: 0, y: 0)
                        )
                        .onTapGesture {
                            withAnimation {
                                selection = index
                            }
                        }
                    if index == 1 {
                        Spacer()
                            .frame(width: 40)
                    }
                }
            }
        }
        .frame(height: 100)
    }
}

