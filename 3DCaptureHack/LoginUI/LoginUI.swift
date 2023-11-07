//
//  LoginUI.swift
//  3DCaptureHack
//
//  Created by Raphael Fassotte on 07/11/2023.
//

import SwiftUI

struct LoginUI: View {
    @State var email = ""
    @State var password = ""

    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0.9)
                VStack {
                    Text("Log In")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .foregroundColor(Color.primary.opacity(0.4))

                    Text("Login to your account")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Divider().padding()

                    VStack(spacing: 12) {
                        TextField("Enter username", text: $email)
                            .modifier(ConcaveGlassModifier())

                        SecureField("Enter password", text: $password)
                            .modifier(ConcaveGlassModifier())
                        Button {
                            //TODO: - Faire l'action
                        } label: {
                            ZStack{
                                Text("Create my account now!")
                                    .bold()
                                    .padding(.top, 20)
                            }
                        }
                    }
                    .padding()

                    Divider().padding()

                    Button {
                        //TODO: - Faire l'action
                    } label: {
                        ZStack {
                            Text("CONNECT")
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .modifier(ConvexGlassModifier())
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .foregroundColor(Color.primary.opacity(0.35))
                .foregroundStyle(.ultraThinMaterial)
                .cornerRadius(35)
                .padding()
            }
        } else {
            VStack {
            }
        }
    }
}

#Preview {
    LoginUI()
}
