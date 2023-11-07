//
//  FlatGlassModifier.swift
//  3DCaptureHack
//
//  Created by Raphael Fassotte on 07/11/2023.
//

import SwiftUI

struct FlatGlassModifier : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .padding()
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
        } else {
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(14)
        }
    }
}
