//
//  CaptureUI.swift
//  3DCaptureHack
//
//  Created by Student08 on 07/11/2023.
//

import Foundation
import RealityKit
import SwiftUI

@available(iOS 17.0, *)
struct CapturePrimaryView: View {
    @EnvironmentObject var appModel: AppDataModel
    var session: ObjectCaptureSession

    //@State var showInfo: Bool = false
    @State private var showOnboardingView: Bool = false

    var body: some View {
        ZStack {
            if session.userCompletedScanPass {
                VStack {
                    ObjectCapturePointCloudView(session: session)
                    Button(
                        action: {
                            session.finish()
                        },
                        label: {
                            Text("Terminer")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 20)
                                .background(.blue)
                                .clipShape(Capsule())
                        })
                }
            } else {
                    ObjectCaptureView(session: session/*,
                                                       cameraFeedOverlay: { GradientBackground() }*/)
                    .transition(.opacity)
                    if shouldShowOverlayView {
                        CaptureOverlayView(session: session/*, showInfo: $showInfo*/)
                    }
                }
        }
    }
    private var shouldShowOverlayView: Bool {
        /*!showInfo &&*/ !appModel.showPreviewModel && !session.isPaused && session.cameraTracking == .normal
    }
}

/*private struct GradientBackground: View {
    private let gradient = LinearGradient(
        colors: [.black.opacity(0.4), .clear],
        startPoint: .top,
        endPoint: .bottom
    )
    private let frameHeight: CGFloat = 300

    var body: some View {
        VStack {
            gradient
                .frame(height: frameHeight)

            Spacer()

            gradient
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(height: frameHeight)
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}*/
