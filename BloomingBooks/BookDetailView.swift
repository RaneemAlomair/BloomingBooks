//
//  BookDetailView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 12/02/1447 AH.
//

import SwiftUI

struct BookDetailView: View {
    var backgroundColor = Color.bloomingBackground
    @ObservedObject var vm: BooksListViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    let book: Book
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    VStack(alignment: .center, spacing: 16) {
                        Image(book.coverName ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 200)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(radius: 4)
                            .padding()
                            .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(book.title)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.bloomingText)
                                

                            Text(book.author)
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text(book.subtitle)
                                .font(.headline)
                                .foregroundColor(.bloomingText)
                                
                            
                        }
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                }
                .padding()
            }
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let vm = BooksListViewModel.preview
    BookDetailView(vm: vm, book: .init(title: "It Ends With Us", author: "Colleen Hoover", subtitle: "A guide to building good habits and breaking bad ones.", coverName: "ItEndWithUs"))
}
