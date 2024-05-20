//
//  ChargingView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 16.05.2024.
//
import SwiftUI
//MARK: - Constants
enum Constants {
    static let chargingTitle = "CHARGING"
    static let nearbySuperchargers = "Nearby Superchargers"
    static let teslaSuperchargerKhabarovsk = "Tesla Supercharger - \nMontreal, QC"
    static let available4of4 = "2 / 4 available"
    static let teslaSuperchargerVladivostok = "Tesla Supercharger - \nMascouche, VLD"
    static let available1of5 = "2 / 2 available"
    static let distance1_3km = "1.3 km"
    static let distance842km = "842 km"
    static let backButtonImage = "backButton"
    static let gearImage = "gear"
    static let expandedImage = "expanded"
    static let collapsedImage = "collapsed"
    static let mapPointImage = "mapPoint"
    static let chargingCarImage = "chargingCar"
    static let procent = "100%"
    static let procents = "75%"
}
//MARK: - Constants
struct ChargingView: View {
    @State private var isSettingsTapped = false
    @State private var isExpanded = false
    @State private var firstOpacity: Double = 0
    @State private var secondOpacity: Double = 0
    @State private var selectedTab = 1
    
    @Environment(\.dismiss) private var dismiss
    // MARK: - Body
    var body: some View {
        createColoredBackgroundStack(color: backgroundGradient) {
                ZStack {
                    VStack {
                        Spacer()
                            .frame(height: 60)
                        HStack {
                            buttonBack
                            chargingTitle
                            settingButton
                        }
                        ZStack {
                            imageCarView
                            procentTitle
                        }
                        chargingPathView
                        procentView
                        superchargersDropListView
                        Spacer()
                    }
                    .frame(height: UIScreen.main.bounds.height)
                    customSlider()
                        .position(x: UIScreen.main.bounds.width / 2, y: 480)
                        .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
        
        .ignoresSafeArea()
    }
    // MARK: - Visual Components
    private var procentTitle: some View {
        Text(Constants.procent)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.title)
            .offset(y: 90)
    }
    
    private var procentView: some View {
        HStack {
            Text(Constants.procents)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
            Text(Constants.procent)
                .foregroundColor(.white)
        }
        .position(x: 270)
    }
    
      private var chargingPathView: some View {
          ChargingPath()
                      .fill(LinearGradient(
                        gradient: Gradient(colors: [.topGradientCharging, .bottomGradientCharging]),
                          startPoint: .top,
                          endPoint: .bottom
                      ))
              .frame(width: 300, height: 60)
              .padding()
              .shadow(color: .bottomGradientCharging.opacity(0.2), radius: 15, x: 0, y: -45)
      }
    
    func customSlider() -> some View {
            CustomSliderView(
                value: .constant(0),
                minValue: 0,
                maxValue: 100,
                offset: .constant(275),
                startColor: .constant(.colorDarkGray),
                endColor: .constant(.green)
            )
            .frame(width: 300)
            .padding(.horizontal, 20)
            .padding(.trailing, 35)
        }
        
    private var imageCarView: some View {
        Image(Constants.chargingCarImage)
            .shadow(color: .veryBlackGradient, radius: 100)
    }
    
    private var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            Image(Constants.backButtonImage)
                .renderingMode(.template)
                .tint(.navigationButton)
                .frame(width: 22, height: 22)
                .scaledToFit()
                .configureGradientCircleButtonImage()
                .overlay {
                    Circle()
                        .stroke(circleGradient, lineWidth: 2.5)
                }
        }
        .applyShadowedCircleButton()
    }
    
    private var chargingTitle: some View {
        Text(Constants.chargingTitle)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
            .frame(width: 110)
            .padding(.horizontal, 50)
    }
    
    private var settingButton: some View {
        Button {
            withAnimation {
                isSettingsTapped.toggle()
            }
        } label: {
            Image(Constants.gearImage)
                .resizable()
                .renderingMode(.template)
                .tint(.navigationButton)
                .frame(width: 22, height: 22)
                .configureGradientCircleButtonImage()
                .overlay {
                    Circle()
                        .stroke(circleGradient, lineWidth: 2.5)
                }
        }
        .applyShadowedCircleButton()
    }
    
    private var circleGradient: LinearGradient {
        LinearGradient(colors: [.lockedGradientMiddle.opacity(0.5), .circleButtonGradientTop.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var superchargersDropListView: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 45)
                    HStack {
                        Text(Constants.nearbySuperchargers)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                        Button {
                            withAnimation {
                                isExpanded.toggle()
                                chargingStationsAnimationView()
                            }
                        } label: {
                            Image(isExpanded ? Constants.expandedImage : Constants.collapsedImage)
                                .renderingMode(.template)
                                .tint(.white)
                                .frame(width: 13, height: 22)
                                .scaledToFit()
                                .applyDropMenuGradientCircle()
                                .overlay {
                                    Circle()
                                        .stroke(.dropMenuButtonGradientBottom.opacity(0.5), lineWidth: 2)
                                }
                            Spacer()
                                .frame(width: 10)
                        }
                    }
                    Spacer()
                    VStack {
                        if isExpanded {
                            superchargersStationsView
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 45)
                        .fill(
                            .dropMenu.opacity(0.5)
                            .shadow(.inner(color: .black.opacity(0.8), radius: 7, x: 5, y: 5))
                            .shadow(.inner(color: .dropMenuButtonGradientTop.opacity(1), radius: 10, x: -5, y: -5))
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 45)
                                .stroke(Color.clear, lineWidth: 2)
                        }
                )
                .frame(width: 330, height: isExpanded ? 370 : 150)
                .animation(.easeInOut(duration: 0.5), value: isExpanded)
                .offset(y: min(geometry.frame(in: .global).maxY - UIScreen.main.bounds.height + 120, 0))
            }
        }
        .position(x: 230, y: -15)
    }
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(colors: [.lockButtonGradientBottom, .topUnlockGradient, .bottomChareGradient], startPoint: .top, endPoint: .bottom)
    }
    
    private var superchargersStationsView: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(Constants.teslaSuperchargerKhabarovsk)
                        .foregroundColor(.white.opacity(0.7))
                        .fontWeight(.semibold)
                    Text("4")
                        .foregroundColor(.white)
                    +
                    Text(Constants.available4of4)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .center) {
                    Image(Constants.mapPointImage)
                    Text(Constants.distance1_3km)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(width: 70)
            }
            .opacity(firstOpacity)
            Spacer()
                .frame(height: 40)
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(Constants.teslaSuperchargerVladivostok)
                        .foregroundColor(.white.opacity(0.7))
                        .fontWeight(.semibold)
                    Text("1")
                        .foregroundColor(.white)
                    +
                    Text(Constants.available1of5)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .center) {
                    Image(Constants.mapPointImage)
                    Text(Constants.distance842km)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(width: 70)
            }
            .opacity(secondOpacity)
            Spacer()
                .frame(height: 0)
        }
    }
    
    private func chargingStationsAnimationView() {
        if isExpanded {
            withAnimation(.easeIn(duration: 0.5)) {
                firstOpacity = 1
            }
            withAnimation(.easeIn(duration: 0.5).delay(0.5)) {
                secondOpacity = 1
            }
        } else {
            withAnimation(.linear(duration: 0.1)) {
                secondOpacity = 0
            }
            withAnimation(.linear(duration: 0.1)) {
                firstOpacity = 0
            }
        }
    }
}

#Preview {
    ChargingView()
}
