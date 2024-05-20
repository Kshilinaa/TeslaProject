//
//  MainTabBarView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 16.05.2024.
//

import SwiftUI
/// Основное представление с вкладками
struct MainTabView: View {
    /// Состояние для отслеживания выбранной вкладки
    @State private var selectedTab = 0
    // MARK: - Body
    var body: some View {
        CustomTabView(selection: $selectedTab) {
            VStack {
                if selectedTab == 0 {
                    TeslaScreenView()
                        
                } else {
                    ChargingView()
                        .transition(.opacity)
                }
            }
        }
        .ignoresSafeArea()
    }
}
#Preview {
    MainTabView()
        .environment(\.colorScheme, .dark)
}
