//
//  Network.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 10/03/1447 AH.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func get<T: Decodable>(_ url: URL, headers: [String: String]) -> AnyPublisher<T, Error>
}

final class Network: NetworkProtocol {
    func get<T: Decodable>(_ url: URL, headers: [String: String] = [:]) -> AnyPublisher<T, Error> {
        var req = URLRequest(url: url)
        // يمر على كل الهيدرز ويضيفها للطلب.
        //$0 هو اسم الهيدر (المفتاح)، $1 قيمته.
        headers.forEach { req.setValue($1, forHTTPHeaderField: $0) }
        print("🚀Request started" + "\(url)" )
        return URLSession.shared.dataTaskPublisher(for: req)
        // يحول الاوتبوت الى داتا مع امكانيه رمي خطا
            .tryMap { output -> Data in
                guard let http = output.response as? HTTPURLResponse,
                      (200..<300).contains(http.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

func currentLanguageCode() -> String {
    if #available(iOS 16.0, *) {
        return Locale.current.language.languageCode?.identifier ?? "en"
    } else {
        return Locale.current.languageCode ?? "en"
    }
}
