//
//  BloomingBooksApp.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 11/02/1447 AH.
//

import SwiftUI

@main
struct BloomingBooksApp: App {
    
    init() {
        NotificationManager.instance.configure()
        NotificationManager.instance.requestAuthIfNeededAndSchedule6h()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
