//
//  CaptureUI.swift
//  3DCaptureHack
//
//  Created by Student08 on 07/11/2023.
//

import SwiftUI
import RealityKit

var session = ObjectCaptureSession()

struct CapturePrimaryView: View {
    var body: some View {
        ZStack {
            ObjectCapturedView(session: session)
        }
    }
}

#Preview {
    CapturePrimaryView()
}
