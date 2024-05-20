//
//  ClimateCustomSlider.swift
//  TeslaProject
//
//  Created by Ксения Шилина on 15.05.2024.
//

import SwiftUI
/// Вью для кастомного слайдера
struct CustomSliderView: View {
    /// Связанное состояние для значения слайдера
    @Binding private var value: Double
    /// Связанное состояние для смещения слайдера
    @Binding var offset: Double
    /// Последнее смещение слайдера
    @State private var lastOffset = 0.0
    /// Предыдущее значение слайдера
    @State private var previousValue = 15
    /// Начальный цвет слайдера
    @Binding var startColor: Color
    /// Конечный цвет слайдера
    @Binding var endColor: Color
    /// Количество шагов между значениями слайдера
    var sets: Double = 0
    /// Минимальное значение слайдера
    private let minValue: Int
    /// Максимальное значение слайдера
    private let maxValue: Int
   
    /// Инициализатор для кастомного слайдера
    init(
        value: Binding<Double>,
        minValue: Int,
        maxValue: Int,
        offset: Binding<Double>,
        startColor: Binding<Color>,
        endColor: Binding<Color>
    ) {
        _value = value
        self.minValue = minValue
        self.maxValue = maxValue
        _offset = offset
        _startColor = startColor
        _endColor = endColor
    }
    // MARK: - Body
    var body: some View {
        GeometryReader { reader in
            let maxSliderWidth = reader.size.width - 20
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    colorfulSliderTrackView
                    valueSliderThumbView
                    sliderIndicatorImage
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ dragValue in
                                    var translation = dragValue.translation.width + lastOffset
                                    translation = min(max(translation, 0), maxSliderWidth)
                                    let dragPercent = getDragPercent(translation: translation, of: maxSliderWidth)
                                    let valueNum = dragPercentToValue(dragPercent: dragPercent)
                                    value = Double(valueNum)
                                    offset = valueToFillPercent(valueNum) * maxSliderWidth
                                })
                                .onEnded({ _ in
                                    lastOffset = offset
                                })
                        )
                }
                .frame(height: 25)
            }
        }
        .frame(maxHeight: 30)
    }
    // MARK: - Visual Components
    private var colorfulSliderTrackView: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color("colorDarkGray"), Color("ColorGrayCustom")]), startPoint: .top, endPoint: .bottom)
            )
            .frame(height: 12)
    }
    
    private var sliderIndicatorImage: some View {
        Image("sliderIndicator")
            .resizable()
            .frame(width: 45, height: 25)
            .offset(x: offset - 3, y: 0)
    }
    
    private var currentSliderColor: Color {
        value < 24 ? startColor : endColor
    }
    
    private var valueSliderThumbView: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(currentSliderColor)
            .frame(width: offset, height: 10)
    }
    
    private func valueToFillPercent(_ result: Int) -> CGFloat {
        Double(result - minValue) / Double((maxValue - minValue))
    }
    
    private func getDragPercent(translation: CGFloat, of maxWidth: CGFloat) -> CGFloat {
        translation / maxWidth
    }
    
    private func dragPercentToValue(dragPercent: CGFloat) -> Int {
        let actualValue = Int(dragPercent * Double(maxValue - minValue) + Double(minValue))
        let remainder = actualValue % step
        var roundedValue = actualValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if remainder < step / 2 {
                roundedValue = actualValue - remainder
            } else {
                roundedValue = actualValue - remainder + step
            }
        }
        return Int(roundedValue)
    }
    
   
    
    private let step = 1
}
