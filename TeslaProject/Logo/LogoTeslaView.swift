//
//  LogoTeslaView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 14.05.2024.
//

import SwiftUI
/// Вью для логотипа Tesla с анимацией
struct LogoTeslaView: View {
    // MARK: - State
    /// Состояние для управления анимацией
    @State private var isAnimating = false
    /// Состояние для отслеживания завершения анимации
    @State private var animationCompleted = false
    // MARK: - Body
    var body: some View {
        createBackgroundStack {
            VStack {
                ZStack {
                    logoView
                        .onAppear {
                            withAnimation {
                                isAnimating = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                                withAnimation {
                                    animationCompleted = true
                                }
                            }
                        }
                    if animationCompleted {
                        StartView()
                    }
                }
            }
        }
    }
    // MARK: - Visual Components
    var logoView: some View {
        VStack() {
            TopLogoTesla()
                .fill(Color.white.opacity(0.7))
                .overlay {
                    TopLogoTesla()
                }
                .shadow(color: .white, radius: 3)
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.2)
                .animation(Animation.easeInOut(duration: 2).delay(0.3))
                .transition(.opacity)
               
            BottomLogoTesla()
                .fill(Color.white.opacity(0.9))
                .overlay {
                    BottomLogoTesla()
                }
                .shadow(color: .white, radius: 3.5)
                .frame(height: 750)
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.2)
                .animation(Animation.easeInOut(duration: 2).delay(0.3))
                .transition(.opacity)
        }
    }
}

struct LogoTeslaView_Previews: PreviewProvider {
    static var previews: some View {
        LogoTeslaView()
            .environment(\.colorScheme, .dark)
    }
}
