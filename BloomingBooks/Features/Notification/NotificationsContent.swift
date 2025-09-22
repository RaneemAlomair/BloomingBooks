//
//  NotificationsContent.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 30/03/1447 AH.
//

import SwiftUI
import UserNotifications

extension NotificationManager {
    func makeBooksContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()

        let titles = [
            "Discover new books 📚",
            "Fresh picks for you ✨",
            "Explore today’s titles 🌼",
            "Your next favorite awaits 🔎"
        ]
        content.title = titles.randomElement() ?? "Discover new books 📚"

        let subtitles = [
            "Browse the latest arrivals",
            "Check today’s featured picks",
            "Find something new to add to Favorites",
            "See what’s trending now"
        ]
        content.subtitle = subtitles.randomElement() ?? "Browse the latest arrivals"

        let bodies = [
            "Open the app to discover new titles and save your favorites.",
            "Tap to explore fresh arrivals, curated lists, and top trends.",
            "Find a standout book today and add it to your Favorites.",
            "New titles just landed — take a quick look!"
        ]
        content.body = bodies.randomElement() ?? "Open the app to discover new titles and save your favorites."

        content.sound = .default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber

        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
            content.relevanceScore = 0.5
        }

        content.userInfo = ["source": "six-hour-reminder", "type": "reading"]
        return content
    }
}
