//
//  FavoritesView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 12/02/1447 AH.
//

import SwiftUI

struct FavoritesView: View {
    var backgroundColor = Color.bloomingBackground
    @ObservedObject var vm: BooksListViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    //0$ امر على كل كتاب
    // اختار اذا isFavorite true
    var favorites: [Book] {
        vm.allBooks.filter { $0.isFavorite }
    }

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                Text("Favorites")
                    .font(.largeTitle).bold()
                    .foregroundColor(.bloomingText)

                if favorites.isEmpty {
                    VStack(spacing: 12) {
                        Text("No favorites yet")
                            .font(.headline)
                            .foregroundColor(.bloomingText)
                        Text("Tap the heart on any book to add it here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(favorites) { book in
                            NavigationLink {
                                BookDetailView( vm: vm, book: book )
                            } label: {
                                FavoriteRowView(book: book , vm: vm)
                            }
                            .listRowBackground(Color.bloomingBackground)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }

    }
}



struct FavoriteRowView: View {
    let book: Book
    @ObservedObject var vm: BooksListViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(book.coverName ?? "")
                .resizable()
                .frame(width: 80, height: 110)
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.title3).bold()
                    .foregroundColor(.bloomingText)

                Text(book.author)
                    .foregroundColor(.secondary)

                Text(book.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Button {
                vm.toggleFavorite(book)
            } label: {
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .font(.title3)
                    .foregroundColor(book.isFavorite ? .red : .gray)
            }
            .buttonStyle(.plain)

        }
        .contentShape(Rectangle())
    }
}
