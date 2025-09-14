//
//  BookRowView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 10/03/1447 AH.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    @ObservedObject var vm: BooksListViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            //CoverImageView(coverID: book.coverI)
            CoverImageView(url: book.coverURL)
                .frame(width: 80, height: 110)

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title ?? "—")
                    .font(.headline)
                    .foregroundColor(.bloomingText)

                Text(book.authorText)
                    .foregroundColor(.gray)

                Text(book.yearText)
                    .font(.caption)
                    .foregroundColor(.gray)
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
    }
}
