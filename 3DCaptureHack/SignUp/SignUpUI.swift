//
//  SignUpUI.swift
//  3DCaptureHack
//
//  Created by Raphael Fassotte on 07/11/2023.
//

import SwiftUI

struct SignUpUI: View {
    @State var email = ""
    @State var password = ""
    @State var passwordAgain = ""
    @State var username = ""
    @State var showAlert = false

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
                    Text("Sign up")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .foregroundColor(Color.primary.opacity(0.4))

                    Text("Create a new account")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Divider().padding()

                    VStack(spacing: 12) {
                        EnterUsernameView(username: $username)

                        EnterEmailView(email: $email)

                        EnterPasswordView(password: $password)

                        ConfirmPasswordView(passwordAgain: $passwordAgain, password: $password, showAlert: showAlert)
                    }
                    .padding()

                    Divider().padding()

                    Text("By signing up you accept the **Terms of Service** and **Privacy Policy**")
                        .font(.footnote)

                    Button {
                        if password != passwordAgain {
                            showAlert = true
                        }
                    } label: {
                        ZStack {
                            Text("SIGN UP")
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .modifier(ConcaveGlassModifier())
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
    SignUpUI()
}

struct EnterUsernameView: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("Enter username", text: $username)
            .modifier(ConcaveGlassModifier())
    }
}



struct EnterEmailView: View {
    
    @Binding var email: String
    @State private var isEmailValid: Bool = true // État pour valider l'email
    @State private var showAlert = false

    var body: some View {
        TextField("Enter email", text: $email)
            .modifier(ConcaveGlassModifier())
            .onChange(of: email, perform: { newValue in
                // Valider l'email lorsque sa valeur change
                isEmailValid = isEmailValid(email: newValue)
            })
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.red, lineWidth: 1)
                    .opacity(isEmailValid ? 0 : 1)
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Format d'email invalide"),
                    message: Text("Veuillez entrer un email valide au format nom@domaine.com."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onTapGesture {
                if !isEmailValid {
                    showAlert = true
                }
            }
    }
    
    // Fonction de validation de l'email à l'aide d'une expression régulière
    private func isEmailValid(email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}



struct EnterPasswordView: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Enter password", text: $password)
            .modifier(ConcaveGlassModifier())
    }
}

struct ConfirmPasswordView: View {
    
    @Binding var passwordAgain: String
    @Binding var password: String // Ajout de la liaison au mot de passe
    @State  var showAlert: Bool

    var body: some View {
        SecureField("Re-enter password", text: $passwordAgain)
            .modifier(ConcaveGlassModifier())
            
    }
}
