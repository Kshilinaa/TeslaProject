//
//  ContentView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 13.05.2024.
//

import SwiftUI

struct TeslaScreenView: View {
    // MARK: - Constants
    private enum Constants {
        static let headerTitle = "Tesla"
        static let kilometers = "187 km"
        static let lockedText = "Lock"
        static let unlockedText = "Unlock"
        static let text = "Тут будут экран с характеристиками"
    }
    // MARK: - State
    @Environment(\.dismiss) private var dismiss
    @State private var tagSelected = 0
    @State private var shouldNavigateToLockView = false
    @State private var shouldNavigateToClimateView = false
    @State private var shouldNavigateToEnergyView = false
    @State private var shouldNavigateToCharacteristicsView = false
    
    // MARK: - Body
    var body: some View {
            createBackgroundStack {
                VStack {
                    headerView
                    imageView
                    controlPanelView
                    Spacer()
                    navigationView
                    Spacer()
                    
              }
            .navigationBarHidden(true)
        }
    }
    // MARK: - Visual Components
    private var gradient: LinearGradient {
        LinearGradient(colors: [.topGradient, .bottomGradient], startPoint: .bottom, endPoint: .top)
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.headerTitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
                Text(Constants.kilometers)
                    .font(.system(size: 17, weight: .semibold))
                    .opacity(0.4)
            }
            Spacer()
        }
        .padding(.all, 25)
    }
    
    private var imageView: some View {
        Image(.carRightSide)
            .resizable()
            .scaledToFit()
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6),  radius: 15, x: 10, y: 10)
            
    }
    
    private var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                Button {
                    withAnimation {
                        tagSelected = index
                        navigateToViews()
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .applyUnselectedCircleStyle()
                        .overlay {
                            Circle()
                                .stroke(gradient, lineWidth: 3)
                                .opacity(tagSelected == index ? 1 : 0)
                        }
                }

            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(.backgroundMain))
        .applySoftShadowEffect()
        
    }
    
    private var navigationView: some View {
        VStack {
            NavigationLink(
                destination: ClimateView()
                    .animation(.easeInOut),
                isActive: $shouldNavigateToClimateView,
                label: {})
            NavigationLink(
                destination: ChargingView()
                    .animation(.easeInOut),
                isActive: $shouldNavigateToEnergyView,
                label: {})
            NavigationLink(
                destination: Text(Constants.text)
                    .animation(.easeInOut),
                isActive: $shouldNavigateToCharacteristicsView,
                label: {})
        }
    }
    
    private func navigateToViews() {
        switch tagSelected {
            case 1:
                dismiss()
        case 2:
            shouldNavigateToClimateView.toggle()
        case 3:
            shouldNavigateToEnergyView.toggle()
        case 4:
            shouldNavigateToCharacteristicsView.toggle()
        default:
            break
        }
    }
}

#Preview {
    TeslaScreenView()
        .environment(\.colorScheme, .dark)
}
