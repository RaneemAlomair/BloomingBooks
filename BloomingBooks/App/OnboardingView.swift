//
//  OnboardingView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 22/03/1447 AH.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("preferredCategory") private var preferredCategory = ""
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    @State private var step = 0
    @State private var selected = ""

    // label == query (بسيطة)
    private let categories = [
        "Fantasy", "Mystery", "Romance", "Science Fiction",
        "History", "Biography", "Self-Help", "Horror",
        "Children", "Poetry", "Technology", "Business",
        "Cooking", "Travel", "Religion", "Philosophy",
        "Art", "Education", "Sports", "Health"
    ]

    private let grid = [GridItem(.flexible()), GridItem(.flexible())]
    private let totalPages = 2

    var body: some View {
        ZStack {
            Color.bloomingBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                   // if step == 1 {
                        Button("Skip") {
                            preferredCategory = ""
                            hasCompletedOnboarding = true
                        }
                        .foregroundColor(.secondary)
                   // }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)

                // الصفحات
                TabView(selection: $step) {
                    // Page 1 — Intro
                    VStack {
                        Spacer(minLength: 20)

                        Image("openBook")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 260)

                        Text("Welcome to Blooming Books 🌼")
                            .font(.title2).bold()
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)

                        Text("Pick a favorite category and we'll start from there.")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Spacer()
                    }
                    .tag(0)

                    // Page 2 — Pick category
                    VStack(spacing: 0) {
                        Text("Choose your favorite category")
                            .font(.title2).bold()
                            .padding(.top, 6)

                        ScrollView {
                            LazyVGrid(columns: grid, spacing: 12) {
                                ForEach(categories, id: \.self) { cat in
                                    let isSelected = (selected == cat)
                                    Button {
                                        selected = cat
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    } label: {
                                        Text(cat)
                                            .frame(maxWidth: .infinity, minHeight: 72)
                                            .padding(.horizontal, 12)
                                            .background(isSelected ? Color.bloomingPrimary : Color.gray.opacity(0.15))
                                            .foregroundColor(isSelected ? .white : .primary)
                                            .cornerRadius(12)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                    }
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // نخفي نقاط النظام

                // نقاط مخصصة
                HStack(spacing: 8) {
                    ForEach(0..<totalPages, id: \.self) { i in
                        Circle()
                            .fill(i == step ? Color.bloomingPrimary : Color.bloomingPrimary.opacity(0.25))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 6)
            }
        }
        // الفوتر: زر واحد دائمًا في الحافة السفلية (لا يتداخل مع النقاط)
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 8) {
                if step == 0 {
                    Button("Next") {
                        withAnimation(.easeInOut) { step = 1 }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.bloomingPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                } else {
                    Button("Start") {
                        preferredCategory = selected
                        hasCompletedOnboarding = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(selected.isEmpty ? Color.gray.opacity(0.3) : Color.bloomingPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(selected.isEmpty)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.top, 6)
            .padding(.bottom, 10)
            .background(
                Color.bloomingBackground.opacity(0.97)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    OnboardingView()
}
