//
//  StartView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 14.05.2024.
//
import SwiftUI

struct StartView: View {
    
    // MARK: - Constants
    private enum Constants {
        static let hi = "Hi"
        static let welcome = "Welcome back"
        static let lockedTitle = "Lock"
        static let unlockedTitle = "Unlock"
    }
    // MARK: - State
    @State private var shouldNavigate = false
    @State private var settingTapped = false
    @State private var greetingDisplayed = false
    @State private var carLocked = true
   
    // MARK: - Body
    var body: some View {
        NavigationView {
            backgroungGradientStartView(isCarClosed: carLocked) {
                VStack {
                    settingsButtonView
                    NavigationLink(destination: TeslaScreenView().navigationBarHidden(true), isActive: $settingTapped) {
                        EmptyView()
                    }
                    if carLocked {
                        AnyView(darkImageCar)
                    } else {
                        AnyView(lightImageCar)
                    }
                    
                    closeCarControlView
                }
                .overlay(
                    welcomeTextView
                        .opacity(greetingDisplayed ? 1 : 0)
                        .animation(.easeInOut(duration: 2.5))
                        .offset(y: -200)
                )
            }
        }
    }
    
    // MARK: - Visual Components
    private var welcomeTextView: some View {
        VStack {
            Text(Constants.hi)
                .font(.headline)
                .foregroundColor(.gray)
                .scaleEffect(greetingDisplayed ? 1 : 0.001)
                .animation(.easeInOut(duration: 2.0))
            Text(Constants.welcome)
                .font(.system(size: 42))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .scaleEffect(greetingDisplayed ? 1 : 0.001)
                .animation(.easeInOut(duration: 2.5))
        }
    }
    
    private var settingsButtonView: some View {
        NavigationLink {
        MainTabView()
        } label: {
            Image("gear")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.gray)
                .frame(width: 20, height: 20)
                .applyGradientCircleButtonImage()
                .overlay {
                    Circle()
                        .stroke(settingsGradient, lineWidth: 2.5)
                }
        }
        .applyShadowedCircleButton()
        .offset(x: 140, y: -120)
    }
    
    private var lightImageCar: some View {
        Image(.carFrontLight)
            .resizable()
            .frame( height: 327)
            .scaleEffect(carLocked ? 0.1 : 1.0)
            .frame(maxWidth: .infinity, maxHeight: 330)
            .shadow(color: .shadowCar.opacity(0.35),  radius: 44.4)
            .offset(x: 5)
    }
    
    private var darkImageCar: some View {
        Image(.carFrontDark)
            .resizable()
            .frame( height: 280)
            .scaleEffect(carLocked ? 1 : 1.0)
            .frame(maxWidth: .infinity, maxHeight: 330)
            .offset(y: -45)
    }
    
    private var closeCarControlView: some View {
        Button {
            withAnimation(.easeInOut(duration: 2)) {
                carLocked.toggle()
                greetingDisplayed.toggle()
            }
        } label: {
            HStack(spacing: 35) {
                Text(carLocked ? Constants.lockedTitle : Constants.unlockedTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 56)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Image(carLocked ? "lockClose" : "lockOpen")
                    .padding()
                    .overlay {
                        Circle()
                            .stroke(.lockButtonGradientTop, lineWidth: 2)
                    }
                    .background(
                        Circle()
                            .fill(
                                
                                lockedBackgroundGradient
                                    .shadow(.inner(color: .settingsButton, radius: 1, x: -0.5, y: -0.5))
                                    .shadow(.inner(color: .lockBackground, radius: 5, x: 5, y: 5))
                            )
                    )
                    .applyLockButtonStyle()
            }
            .frame(width: 190)
            .padding()
        }
        .frame(width: 190)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    .lockButtonGradientTop
                        .shadow(.inner(color: .lockedGradientTop, radius: 6, x: -10, y: -10))
                        .shadow(.inner(color: .startLockedPanelM, radius: 5, x: 5, y: 0))
                )
        )
        .offset(y: 100)
    }
    
    private var lockedBackgroundGradient: LinearGradient {
        LinearGradient(colors: [.lockedGradientTop, .startLockedPanelM, .lockedGradientBottom], startPoint: .top, endPoint: .bottom)
    }
    
    private var settingsGradient: LinearGradient {
        LinearGradient(colors: [.startLockedPanelM.opacity(0.5), .circleButtonGradientTop.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    StartView()
        .environment(\.colorScheme, .dark)
}
