//
//  ThemeManager.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 23/02/1447 AH.
//
//import SwiftUI
//
//final class ThemeManager: ObservableObject {
//    static let shared = ThemeManager()   // Singleton instance
//
//    @AppStorage("isDarkMode") private var storedDarkMode: Bool = false
//
//    @Published var isDarkMode: Bool
//
//
//    func toggle() {
//        withAnimation(.easeInOut) {
//            isDarkMode.toggle()
//            storedDarkMode = isDarkMode
//        }
//    }
//}
