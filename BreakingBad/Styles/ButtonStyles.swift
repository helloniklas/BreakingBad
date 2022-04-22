//
//  ButtonStyles.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import SwiftUI

struct AnimateSelectionStyle: ButtonStyle {
    var scaleValue: CGFloat = 0.90
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleValue : 1)
            .animation(.easeOut(duration: 0.6), value: configuration.isPressed)
    }
}
