//
//  ClimatControlView.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 15.05.2024.
//

import SwiftUI

struct ClimateView: View {
    //MARK: - Constants
    private enum Constant {
         static let acText = "A/C"
         static let fanText = "Fan"
         static let teslaSupport = "Tesla Support"
         static let heatText = "Heat"
         static let autoText = "Auto"
         static let colorPickerText = "Color Picker"
         static let onText = "On"
         static let ventText = "Vent"
         static let acOnText = "A/C is ON"
         static let acOffText = "A/C is OFF"
         static let tapToTurnOffText = "Tap to turn off or swipe up \nfor a fast setup"
        static let okTitle = "Visit"
        static let needHelpTitle = "Need help? Visit Tesla Support."
         static let degreeSymbol = "°"
        static let climateTitle = "CLIMATE"
    }
    
    //MARK: - State
    @Environment(\.dismiss) private var dismiss
    @GestureState private var gestureOffset = CGSize.zero
    @State private var currentSettingsOffsetY: CGFloat = 0.0
    @State private var lastSettingsOffsetY: CGFloat = 0.0
    @State private var acOffset = 0.0
    @State private var fanOffset = 0.0
    @State private var heatOffset = 0.0
    @State private var autoOffset = 0.0
    @State private var acValue: Double = 15.0
    @State private var fanValue: Double = 0.0
    @State private var heatValue: Double = 0.0
    @State private var autoValue: Double = 0.0
    @State private var sliderValue = 15
    @State var startColor = Color.yellowNeon
    @State var endColor = Color.blue
    @State private var increasingColor = Color.yellowNeon
    @State private var isExpanded = true
    @State private var isACOn: Bool = false
    @State private var isShowingSupportAlert = false
    //MARK: - Body
    var body: some View {
        createColoredBackgroundStack(color: climateBackgroundGradient) {
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: 60)
                    HStack {
                        backButtonView
                        Spacer()
                            .frame(width: 60)
                        logoClimateView
                        Spacer()
                            .frame(width: 60)
                        settingButtonView
                    }
                    .padding(.horizontal)
                    Spacer()
                        .frame(height: 80)
                    indicatorView
                    Spacer()
                        .frame(height: 60)
                    slidersView
                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height)
                bottomSheetView
            }
            
        }
        .navigationBarBackButtonHidden(true)
    
    }
    // MARK: - Visual Components
    private var backButtonView: some View {
        Button(action: { dismiss() }) {
            Image("backButton")
                .renderingMode(.template)
                .tint(.navigationButton)
                .frame(width: 20, height: 20)
                .scaledToFit()
                .applyGradientCircleButtonImage()
                .overlay {
                    Circle()
                        .stroke(circleGradient, lineWidth: 2.5)
                }
        }
        .applyShadowedCircleButton()
    }
    
    private var logoClimateView: some View {
        Text(Constant.climateTitle)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
    }
    
    private var settingButtonView: some View {
        Button(action: { isShowingSupportAlert.toggle() }) {
            Image("gear")
                .resizable()
                .renderingMode(.template)
                .tint(.navigationButton)
                .frame(width: 20, height: 20)
                .applyGradientCircleButtonImage()
                .overlay {
                    Circle()
                        .stroke(circleGradient, lineWidth: 2.5)
                }
        }
        .applyShadowedCircleButton()
        .alert(isPresented: $isShowingSupportAlert) {
            Alert(
                title: Text(Constant.teslaSupport),
                message: Text(Constant.needHelpTitle),
                primaryButton: .default(Text(Constant.okTitle)) {
                    UIApplication.shared.open(URL(string: "https://www.tesla.com/support")!)
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private var bottomSheetView: some View {
        VStack {
            bottomSheetHeaderView
            controlButtonsView
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height + 250)
        .background(RoundedRectangle(cornerRadius: 40).fill(.lockButtonGradientBottom))
        .ignoresSafeArea(.all, edges: .bottom)
        .offset(y: UIScreen.main.bounds.height)
        .offset(y: currentSettingsOffsetY)
        .gesture(dragGesture)
    }
    
    private var indicatorView: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat((acValue - 15) / 15))
                .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round))
                .foregroundColor(acValue < 24 ? startColor : endColor)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 192, height: 192)
                .zIndex(1)
                .opacity(isACOn ? 1 : 0)
                .shadow(color: acValue < 24 ? .yellowNeon : .blue, radius: 7, x: 0, y: 0)
            Circle()
                .fill(climateIndicatorGradient)
                .frame(width: 170, height: 200)
                .applyClimateIndicatorShadow()
            Circle()
                .fill(
                    .darkShadow
                        .shadow(.inner(color: .circleButtonGradientTop.opacity(0.6), radius: 35, x: -60, y: -30))
                )
                .overlay {
                    Text("\(acValue.description.prefix(2))\(Constant.degreeSymbol) C")
                        .font(.system(size: 30, weight: .bold))
                        .opacity(isACOn ? 1 : 0)
                }
                .frame(width: 136, height: 136)
                .background(Circle().stroke(.climateIndicatorMiddle, lineWidth: 1))
                .applyShadowedCircleButton()
        }
    }
    
    private var slidersView: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(spacing: 20) {
                acSliderView
                fanSliderView
                heatSliderView
                autoSliderView
            }
        } label: {}
        .padding(.horizontal)
    }
    
    private var acSliderView: some View {
        HStack {
            Text(Constant.acText)
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button { } label: {
                Image("acImage")
                    .renderingMode(.template)
                    .foregroundColor(isACOn ? .topGradient : .textGray)
            }
            .configureClimateCircleStyle()
            Spacer()
            CustomSliderView(value: $acValue, minValue: 15, maxValue: 30, offset: $acOffset, startColor: $startColor, endColor: $endColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
        }
        .disabled(!isACOn)
        .padding(.top, 10)
        .foregroundColor(.textGray)
    }
    
    private var fanSliderView: some View {
        HStack {
            Text(Constant.fanText)
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button { } label: {
                Image("fanImage")
            }
            .configureClimateCircleStyle()
            Spacer()
            CustomSliderView(value: $fanValue, minValue: 0, maxValue: 100, offset: $fanOffset, startColor: $startColor, endColor: $endColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
        }
        .foregroundColor(.textGray)
        .padding(.top, 10)
        .disabled(!isACOn)
    }
    
    private var heatSliderView: some View {
        HStack {
            Text(Constant.heatText)
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button { } label: {
                Image("heatImage")
            }
            .configureClimateCircleStyle()
            Spacer()
            CustomSliderView(value: $heatValue, minValue: 0, maxValue: 100, offset: $heatOffset, startColor: $startColor, endColor: $endColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
        }
        .foregroundColor(.textGray)
        .padding(.top, 10)
        .disabled(!isACOn)
    }
    
    private var autoSliderView: some View {
        HStack {
            Text(Constant.autoText)
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button { } label: {
                Image("autoImage")
            }
            .configureClimateCircleStyle()
            Spacer()
            CustomSliderView(value: $autoValue, minValue: 0, maxValue: 100, offset: $autoOffset, startColor: $startColor, endColor: $endColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
        }
        .foregroundColor(.textGray)
        .padding(.vertical, 10)
        .disabled(!isACOn)
    }

    private var bottomSheetHeaderView: some View {
        VStack {
            Capsule()
                .fill(.black)
                .frame(width: 60, height: 5)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(isACOn ? Constant.acOnText : Constant.acOffText)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text(Constant.tapToTurnOffText)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    withAnimation {
                        isACOn.toggle()
                        if !isACOn {
                            acValue = 15.0
                            fanValue = 0.0
                            heatValue = 0.0
                            autoValue = 0.0
                        }
                    }
                } label: {
                    Image(systemName: "power")
                        .frame(width: 55, height: 55)
                        .tint(.white)
                        .overlay {
                            Circle()
                                .stroke(.topGradient.opacity(0.5), lineWidth: 4)
                        }
                        .background(
                            Circle()
                                .fill(
                                    .topGradient
                                        .shadow(.inner(color: .blue, radius: 12, x: 15, y: 10))
                                        .shadow(.inner(color: .blue, radius: 10, x: -1, y: -5))
                                )
                        )
                }
                .shadow(color: .darkShadow, radius: 6, x: 0, y: 0)
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    private var controlButtonsView: some View {
        HStack(alignment: .top, spacing: 50) {
            VStack(alignment: .leading) {
                Spacer().frame(height: 15)
                ColorPicker(Constant.colorPickerText, selection: acValue >= 24 ? $endColor : $startColor)
                    .frame(width: 20)
                Spacer().frame(height: 40)
                Text(Constant.onText).font(.system(size: 20))
            }.frame(height: 90)
            
            HStack {
                Button {
                    guard acValue > 15 else { return }
                    acValue -= 1
                    acOffset -= -1
                } label: {
                    Image(systemName: "minus")
                }.disabled(!isACOn)
                
                Text("\(Int(acValue))\(Constant.degreeSymbol)").font(.system(size: 34)).foregroundColor(.white).frame(width: 60)
                
                Button {
                    guard acValue < 30 else { return }
                    acValue += 1
                } label: {
                    Image(systemName: "plus")
                }.disabled(!isACOn)
            }
            
            VStack {
                Spacer().frame(height: 15)
                Button { } label: {
                    Image("Vent")
                }
                Spacer().frame(height: 40)
                Text(Constant.ventText)
            }.frame(height: 80)
        }.frame(height: 100).padding()
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeSettingsOffset()
            }
            .onEnded { value in
                let maxHeight = UIScreen.main.bounds.height / 5
                
                withAnimation {
                    if -currentSettingsOffsetY > maxHeight / 2 {
                        currentSettingsOffsetY = -maxHeight
                    } else {
                        currentSettingsOffsetY = 0
                    }
                    lastSettingsOffsetY = currentSettingsOffsetY
                }
            }
    }
    
    private var circleGradient: LinearGradient {
        LinearGradient(colors: [.lockedGradientMiddle.opacity(0.5), .circleButtonGradientTop.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var climateBackgroundGradient: LinearGradient {
        LinearGradient(colors: [.lockButtonGradientBottom, .topUnlockGradient, .veryBlackGradient], startPoint: .top, endPoint: .bottom)
    }
    
    private var climateIndicatorGradient: LinearGradient {
        LinearGradient(colors: [.graphiteGradient, .veryBlackGradient.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private func onChangeSettingsOffset() {
        DispatchQueue.main.async {
            self.currentSettingsOffsetY = gestureOffset.height + lastSettingsOffsetY
        }
    }
}

#Preview {
    ClimateView()
        .environment(\.colorScheme, .dark)
}
