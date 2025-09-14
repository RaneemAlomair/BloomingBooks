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

    var favorites: [FavoriteSnapshot] { vm.favoriteItems }

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
                        ForEach(favorites) { item in
                            HStack(alignment: .top, spacing: 14) {
                                //CoverImageView(coverID: item.coverI)
                                CoverImageView(url: item.coverURL)
                                    .frame(width: 80, height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title ?? "—")
                                        .font(.title3).bold()
                                        .foregroundColor(.bloomingText)

                                    Text(item.authorText)
                                        .foregroundColor(.secondary)

                                    Text(item.yearText)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }

                                Spacer()

                                Button {
                                    vm.removeFavorite(by: item.id)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.plain)
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
