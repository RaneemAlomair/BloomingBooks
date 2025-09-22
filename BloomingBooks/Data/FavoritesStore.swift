//
//  FavoritesStore.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 10/03/1447 AH.
//

import Foundation

// FavoritesStoreProtocol
protocol FavoritesStoreProtocol {
    func all() -> [FavoriteSnapshot]
    func contains(_ id: String) -> Bool
    func upsert(from book: Book)
    func remove(_ id: String)
    func toggle(_ book: Book)
}

struct FavoriteSnapshot: Codable, Identifiable, Hashable {
    let id: String         
    let title: String?
    let authorText: String
    let yearText: String
    let coverI: Int?
    
    var coverURL: URL? {
        guard let id = coverI else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/id/\(id)-M.jpg")
    }
}

final class FavoritesStore: FavoritesStoreProtocol  {
   // static let shared = FavoritesStore()
    private let defaults: UserDefaults
    private let storageKey = "favorite_book_snapshots"

    // نخزّن سنابشوت كاملة
    private var cache: [FavoriteSnapshot] = []

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if let data = defaults.data(forKey: storageKey),
           let arr = try? JSONDecoder().decode([FavoriteSnapshot].self, from: data) {
            cache = arr
        }
    }
//    private init() {
//        if let data = defaults.data(forKey: storageKey),
//           let arr = try? JSONDecoder().decode([FavoriteSnapshot].self, from: data) {
//            cache = arr
//        }
//    }

    //يرجّع كل السنابشوتات المحفوظة (نعرضها في FavoritesView)
    func all() -> [FavoriteSnapshot] { cache }
    
    func contains(_ id: String) -> Bool {
        cache.contains(where: { $0.id == id })
    }

    func upsert(from book: Book) {
        let snap = FavoriteSnapshot(
            id: book.id,
            title: book.title,
            authorText: book.authorText,
            yearText: book.yearText,
            coverI: book.coverI
        )
        if let idx = cache.firstIndex(where: { $0.id == snap.id }) {
            cache[idx] = snap
        } else {
            cache.append(snap)
        }
        persist()
    }

    func remove(_ id: String) {
        cache.removeAll { $0.id == id }
        persist()
    }

    func toggle(_ book: Book) {
        if contains(book.id) { remove(book.id) } else { upsert(from: book) }
    }

    // يحفظ الكاش الحالي كـ JSON إلى UserDefaults
    private func persist() {
        if let data = try? JSONEncoder().encode(cache) {
            defaults.set(data, forKey: storageKey)
        }
    }
}
