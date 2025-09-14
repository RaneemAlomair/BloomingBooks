//
//  Book.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 16/02/1447 AH.
//

import Foundation

struct Book: Identifiable, Codable {
    let id: String
    let title: String?
    let authorName: [String]?
    let firstPublishYear: Int?
    let coverI: Int?

    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "key"
        case title
        case authorName = "author_name"
        case firstPublishYear = "first_publish_year"
        case coverI = "cover_i"
    }

    var authorText: String { authorName?.joined(separator: ", ") ?? "Unknown Author" }
    var yearText: String { firstPublishYear.map(String.init) ?? "—" }

    var coverURL: URL? {
      guard let id = coverI else { return nil }
      return URL(string: "https://covers.openlibrary.org/b/id/\(id)-M.jpg")
    }

}

// رد البحث (لازم لفّافة لأن الـAPI يرجّع docs[])
struct SearchResponse: Codable {
    let numFound: Int?
    //let start: Int?
    //let numFoundExact: Bool?
    let q: String?
    let offset: Int?
    let docs: [Book]
}
