//
//  CaptureOverlayView+Buttons.swift
//  3DCaptureHack
//
//  Created by Student08 on 07/11/2023.
//


import SwiftUI
import RealityKit
import UniformTypeIdentifiers
import os

extension CaptureOverlayView {
    static let logger = Logger(subsystem: ThreeDCaptureApp.subsystem,
                               category: "CaptureOverlayView+Buttons")

    @available(iOS 17.0, *)
    @MainActor
    struct CaptureButton: View {
        var session: ObjectCaptureSession
        var isObjectFlipped: Bool
        @Binding var hasDetectionFailed: Bool

        var body: some View {
            Button(
                action: {
                    performAction()
                },
                label: {
                    Text(buttonlabel)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 20)
                        .background(.blue)
                        .clipShape(Capsule())
                })
        }

        private var buttonlabel: String {
            if case .ready = session.state {
                return "Continue"
            } else {
                if !isObjectFlipped {
                    return "Start"
                } else {
                    return "Continue"
                }
            }
        }

        private func performAction() {
            if case .ready = session.state {
                logger.debug("here")
                hasDetectionFailed = !(session.startDetecting())
            } else if case .detecting = session.state {
                session.startCapturing()
            }
        }
    }

    @available(iOS 17.0, *)
    struct ResetBoundingBoxButton: View {
        var session: ObjectCaptureSession

        var body: some View {
            Button(
                action: { session.resetDetection() },
                label: {
                    VStack(spacing: 6) {
                        Image("ResetBbox")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)

                        Text("Reset")
                            .font(.footnote)
                            .opacity(0.7)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                })
        }
    }

    @available(iOS 17.0, *)
    struct NextButton: View {
        @EnvironmentObject var appModel: AppDataModel

        var body: some View {
            Button(action: {
                logger.log("next button clicked!")
                appModel.setPreviewModelState(shown: true)
            },
                   label: {
                Text("Next")
                    .modifier(VisualEffectRoundedCorner())
            })
        }
    }

    @available(iOS 17.0, *)
    struct ManualShotButton: View {
        var session: ObjectCaptureSession

        var body: some View {
            Button(
                action: {
                    session.requestImageCapture()
                },
                label: {
                    if session.canRequestImageCapture {
                        Text(Image(systemName: "button.programmable"))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    } else {
                        Text(Image(systemName: "button.programmable"))
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                }
            )
            .disabled(!session.canRequestImageCapture)
        }
    }

    struct DocumentBrowser: UIViewControllerRepresentable {
        let startingDir: URL

        func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentBrowser>) -> UIDocumentPickerViewController {
            let controller = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.item])
            controller.directoryURL = startingDir
            return controller
        }

        func updateUIViewController(
            _ uiViewController: UIDocumentPickerViewController,
            context: UIViewControllerRepresentableContext<DocumentBrowser>) {}
    }

    @available(iOS 17.0, *)
    struct FilesButton: View {
        @EnvironmentObject var appModel: AppDataModel
        @State private var showDocumentBrowser = false

        var body: some View {
            Button(
                action: {
                    logger.log("Files button clicked!")
                    showDocumentBrowser = true
                },
                label: {
                    Image(systemName: "folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22)
                        .foregroundColor(.white)
                })
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
            .sheet(isPresented: $showDocumentBrowser,
                   onDismiss: { showDocumentBrowser = false },
                   content: { DocumentBrowser(startingDir: appModel.scanFolderManager.rootScanFolder) })
        }
    }

    struct HelpButton: View {
        // This sample passes this binding in from the parent to allow the button to stop showing the panel.
        @Binding var showInfo: Bool

        var body: some View {
            Button(action: {
                logger.log("Help button clicked!")
                withAnimation {
                    showInfo = true
                }
            }, label: {
                VStack(spacing: 10) {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22)

                    Text("Help")
                        .font(.footnote)
                        .opacity(0.7)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
            })
        }
    }

    @available(iOS 17.0, *)
    struct CancelButton: View {
        @EnvironmentObject var appModel: AppDataModel

        var body: some View {
            Button(action: {
                logger.log("cancel button clicked!")
                appModel.objectCaptureSession?.cancel()
            }, label: {
                Text("cancel")
                    .modifier(VisualEffectRoundedCorner())
            })
        }
    }

    @available(iOS 17.0, *)
    struct NumOfImagesButton: View {
        var session: ObjectCaptureSession

        var body: some View {
            VStack(spacing: 8) {
                Text(Image(systemName: "photo"))

                Text(String(format: "numOfImages",
                            session.numberOfShotsTaken,
                            session.maximumNumberOfInputImages))
                .font(.footnote)
                .fontWidth(.condensed)
                .fontDesign(.rounded)
                .bold()
            }
            .foregroundColor(session.feedback.contains(.overCapturing) ? .red : .white)
        }
    }

    struct VisualEffectRoundedCorner: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(16.0)
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .cornerRadius(15)
                .multilineTextAlignment(.center)
        }
    }

    struct VisualEffectView: UIViewRepresentable {
        var effect: UIVisualEffect?
        func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
        func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
    }
}
