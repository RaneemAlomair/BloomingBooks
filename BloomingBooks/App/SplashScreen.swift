//
//  SplashScreen.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 15/03/1447 AH.
//

import SwiftUI

struct SplashScreenView: View {
    var backgroundColor = Color.bloomingBackground
    @State private var isActive = false
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0.9

    
    
    var body: some View {
        if isActive {
            RootView()
        } else {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .accessibilityHidden(true)
                    
                    
                    Text("All your Favorite books in one place")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .opacity(opacity)
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    opacity = 1
                    scale = 1.0
                }
                // انتقال تلقائي بعد 2 ثانية
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeIn(duration: 0.25)) {
                        isActive = true
                    }
                }
            }
        }
    }
    
    
    
}

#Preview {
    SplashScreenView()
}
