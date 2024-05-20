//
//  View+Extensions.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 14.05.2024.
//


import SwiftUI

extension View {
    
    func backgroungGradientStartView<Content: View>(isCarClosed: Bool, content:() -> Content) -> some View {
        ZStack {
        if isCarClosed {
        Rectangle()
            .fill(LinearGradient(colors: [.topLaunchBack, .bodyLaunckBack, .bottomLaunchBack], startPoint: .bottom, endPoint: .top))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        } else {
        Rectangle()
             .fill(LinearGradient(colors: [.bottomLaunchOpen, .topLaunchOpen, .bottomLaunchOpen], startPoint: .bottom, endPoint: .top))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
                    }
        content()
    }
    }
    
    func createColoredBackgroundStack<Content: View, S: ShapeStyle>(color: S, content: () -> Content) -> some View {
       ZStack {
           Rectangle()
               .fill(color)
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .ignoresSafeArea(.all)
           content()
       }
   }
    
    func createBackgroundStack<Content: View>(content:() -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(.backgroundMain))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            content()
        }
    }
    
    func applyShadowedCircleButton() -> some View {
        modifier(ShadowedCircleButton())
    }
    
    func configureClimateCircleStyle() -> some View {
        modifier(ClimateCircleGradientStyle())
    }
    
    func applySoftShadowEffect() -> some View {
        modifier(SoftShadowEffect())
    }
    
    func applyUnselectedCircleStyle() -> some View {
        modifier(UnselectedCircleStyle())
    }
    
    func applyGradientCircleButtonImage() -> some View {
        modifier(GradientCircleButtonImage())
    }
    
    func circleButtonConfiguration() -> some View {
        modifier(ShadowedCircleButton())
    }
    
    func applyClimateIndicatorShadow() -> some View {
        modifier(ClimateIndicatorShadow())
    }
    
    
    func configureGradientCircleButtonImage() -> some View {
        modifier(GradientCircleButtonImage())
    }
    
    func applyLockButtonStyle() -> some View {
        modifier(LockButtonStyle())
    }
    
    func applyDropMenuGradientCircle() -> some View {
        modifier(DropMenuGradientCircle())
    }
    
    func applyTabBarShadowStyle() -> some View {
        modifier(TabBarShadowStyle())
    }
}
