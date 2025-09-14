//
//  ErrorCardView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 16/03/1447 AH.
//

import SwiftUI

struct ErrorCardView: View {
    @ObservedObject var vm: BooksListViewModel
    var body: some View {
        
        if vm.errorMessage != nil {
            VStack(spacing: 8) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 40))
                    .foregroundColor(.red)
                
                Text("Connection Error")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
                Text("Please check your internet connection and try again.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                Button(action: { vm.retry() }) {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                //Button("Retry") { vm.retry() }
            }
            .padding()
            .background(Color.bloomingCard)
            .cornerRadius(16)
            .shadow(radius: 5)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        if vm.allBooks.isEmpty && vm.errorMessage == nil && !vm.isLoading {
            VStack(spacing: 6) {
                Text("No books found for “\(vm.searchText.isEmpty ? "Explore" : vm.searchText)”.")
                Text("Try another word.").foregroundStyle(.secondary)
            }
            .padding(.top, 16)
        }
        
    }
}
