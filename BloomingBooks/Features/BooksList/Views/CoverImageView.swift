//
//  CoverImageView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 10/03/1447 AH.
//

import SwiftUI

struct CoverImageView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        //.frame(width: 80, height: 110)
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.15))
                        Image(systemName: "book.closed")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                    Image(systemName: "book.closed")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
