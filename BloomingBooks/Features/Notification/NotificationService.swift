//
//  NotificationService.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 24/03/1447 AH.
//

import SwiftUI
import UserNotifications

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let instance = NotificationManager()
    private let sixHourId = "every-6h"

    func configure() {
        UNUserNotificationCenter.current().delegate = self
    }

    func requestAuthIfNeededAndSchedule6h() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    if granted { self.scheduleEverySixHoursIfNeeded() }
                }
            case .authorized, .provisional:
                self.scheduleEverySixHoursIfNeeded()
            default:
                break
            }
        }
    }

    private func scheduleEverySixHoursIfNeeded() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            guard !requests.contains(where: { $0.identifier == self.sixHourId }) else { return }
            self.scheduleEverySixHours()
        }
    }

    private func scheduleEverySixHours() {
        let content = self.makeBooksContent()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 21600, repeats: true) // 6h
        let request = UNNotificationRequest(identifier: sixHourId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func cancelSixHourNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [sixHourId])
    }

    // Show notification while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
