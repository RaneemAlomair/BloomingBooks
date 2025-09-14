//
//  BooksRepository.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 10/03/1447 AH.
//


import Foundation
import Combine

protocol OpenLibraryRepositoryProtocol {
    func search(q: String, limit: Int, offset: Int)
    -> AnyPublisher<(total: Int, items: [Book]), Error>
}


final class OpenLibraryRepository: OpenLibraryRepositoryProtocol {
    //private let client = Network()
    private let client: NetworkProtocol
    
    init (client: NetworkProtocol ) {
        self.client = client
    }
// ممكن ارجع ارراي فاضي
    func search(q: String, limit: Int, offset: Int) -> AnyPublisher<(total: Int, items: [Book]), Error> {
        guard var comps = URLComponents(string: "https://openlibrary.org/search.json") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        comps.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]

        guard let url = comps.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let headers = ["Accept-Language": currentLanguageCode()]

        // نفّذ الطلب وارجع النتيجة
        return client.get(url, headers: headers) // SearchResponse
            .map { (resp: SearchResponse) in
                (resp.numFound ?? 0, resp.docs) //  مباشرة [Book]
            }
            .eraseToAnyPublisher()
    }
}

