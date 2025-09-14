//
//  BookDetailView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 12/02/1447 AH.
//
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
                       // CoverImageView(coverID: book.coverI)
                        CoverImageView(url: book.coverURL)
                            .frame(width: 190, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 4)
                            .padding()
                            .padding(.bottom)

                        VStack(alignment: .leading, spacing: 6) {
                            Text(book.title ?? "—")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.bloomingText)

                            Text(book.authorText)
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text(book.yearText)
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
