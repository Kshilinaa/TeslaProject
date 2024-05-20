//
//  NeumorphismSelected.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 14.05.2024.
//

import SwiftUI

struct SoftShadowEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: -5, y: -5)
            .shadow(color: .darkShadow, radius: 5, x: 5, y: 5)
    }
}


struct CircularSoftShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .shadow(color: .lightShadow, radius: 5, x: 5, y: 5)
            .applySoftShadowEffect()
    }
}
   
struct GradientCircleButtonImage: ViewModifier {
    var gradient = LinearGradient(colors: [.circleButtonGradientTop, .circleButtonGradientBottom], startPoint: .top, endPoint: .bottom)
    func body(content: Content) -> some View {
        content
            .padding(.all, 20)
            .background(Circle().fill(gradient))
            .shadow(color: .circleButtonGradientTop.opacity(0.9), radius: 6, x: -4, y: -6)
            .shadow(color: .startLockedPanelM.opacity(0.8), radius: 7, x: 3, y: 2)
            
    }
}

struct ShadowedCircleButton: ViewModifier {
    var gradient = LinearGradient(colors: [.circleButtonGradientTop, .circleButtonGradientBottom], startPoint: .top, endPoint: .bottom)
    func body(content: Content) -> some View {
        content
            .shadow(color: .circleButtonGradientTop, radius: 10, x: 0, y: 0)
            .shadow(color: .startLockedPanelM.opacity(0.8), radius: 8, x: 6, y: 9)
            
    }
}

struct TabBarShadowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lockedGradientTop, radius: 5, x: 0, y: -5)
            .shadow(color: .lockedGradientMiddle.opacity(1), radius: 3, x: 0, y: 5)
    }
}
struct DropMenuGradientCircle: ViewModifier {
    var gradient = LinearGradient(colors: [.dropMenuButtonGradientTop, .dropMenuButtonGradientBottom], startPoint: .top, endPoint: .bottom)
    func body(content: Content) -> some View {
        content
            .padding(.all, 20)
            .background(Circle().fill(gradient))
            .shadow(color: .circleButtonGradientTop.opacity(0.8), radius: 10, x: -5, y: -8)
            .shadow(color: .circleButtonGradientTop.opacity(0.7), radius: 2, x: 1, y: 1)
            .shadow(color: .lockedGradientMiddle.opacity(0.8), radius: 8, x: 3, y: 3)
            
    }
}


struct ClimateIndicatorShadow: ViewModifier {
    var gradient = LinearGradient(colors: [.circleButtonGradientTop, .circleButtonGradientBottom], startPoint: .top, endPoint: .bottom)
    func body(content: Content) -> some View {
        content
            .shadow(color: .circleButtonGradientTop, radius: 20, x: -10, y: -10)
            .shadow(color: .lockedGradientMiddle.opacity(0.7), radius: 20, x: 20, y: 20)
            
    }
}

struct LockButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 3)
            .background(Circle().fill(.darkShadow))
    }
}

struct UnselectedCircleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 15)
            .background(Circle().fill(.backgroundMain))
            .applySoftShadowEffect()
            
    }
}

struct ClimateCircleGradientStyle: ViewModifier {
     var climateBackgroundGradient: LinearGradient {
        LinearGradient(colors: [.lockButtonGradientBottom, .topUnlockGradient, .veryBlackGradient], startPoint: .top, endPoint: .bottom)
    }
    func body(content: Content) -> some View {
        content
            .padding(.all, 15)
            .background(Circle().fill(climateBackgroundGradient))
            .shadow(color: .circleButtonGradientTop, radius: 4, x: -4, y: -4)
            .shadow(color: .lockedGradientMiddle, radius: 4, x: 4, y: 4)
            
    }
}
