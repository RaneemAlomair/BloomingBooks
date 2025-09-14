//
//  RootView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 22/03/1447 AH.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var done = false
    @AppStorage("preferredCategory") private var pref = ""

    var body: some View {
        if done {
            RootTabView(initialQuery: pref.isEmpty ? "the" : pref)
        } else {
            OnboardingView()
        }
    }
}
