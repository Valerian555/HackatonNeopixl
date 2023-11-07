//
//  _DCaptureHackApp.swift
//  3DCaptureHack
//
//  Created by Raphael Fassotte on 07/11/2023.
//

import SwiftUI

@main
struct ThreeDCaptureApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        // Configuration de l'apparence de la barre de navigation
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.configureWithOpaqueBackground()
        appearanceNavBar.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearanceNavBar.backgroundColor = UIColor(Color.black.opacity(0.2))
        appearanceNavBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearanceNavBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        // Appliquer l'apparence à la barre de navigation globalement
        UINavigationBar.appearance().standardAppearance = appearanceNavBar
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNavBar
        
        // Configurer l'apparence de la TabBar
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearanceTabBar.backgroundColor = UIColor(Color.black.opacity(0.2))
        
        // Utiliser cette apparence lorsque le TabView n'est pas déroulé
        UITabBar.appearance().standardAppearance = appearanceTabBar
        // Utiliser cette apparence lorsque le TabView est déroulé tout en haut
        UITabBar.appearance().scrollEdgeAppearance = appearanceTabBar
    }

    var body: some Scene {
        WindowGroup {
            SignUpUI()
        }
    }
}
