//
//  TabBarAppearance.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit

public class TabBarAppearance {
    
    public static func configure() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}
