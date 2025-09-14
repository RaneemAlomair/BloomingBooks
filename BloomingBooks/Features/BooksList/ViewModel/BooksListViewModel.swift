//
//  BooksListViewModel.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 19/02/1447 AH.
//

import Foundation
import Combine

class BooksListViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var allBooks: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    @Published var favoriteItems: [FavoriteSnapshot] = []

    //private let repo = OpenLibraryRepository()
    private let repo: OpenLibraryRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    //private let favorites = FavoritesStore.shared
    private let favorites: FavoritesStoreProtocol

    // Pagination
    private let pageSize = 20
    private var offset = 0
    private var total = 0 //العدد الكلي للنتائج من السيرفر (numFound). نستخدمه لمعرفة متى نتوقف عن “Load more”.
    private var currentQuery = ""
    private let initialQuery: String // عشان تجيني كتب قبل البحث

    init(repo: OpenLibraryRepositoryProtocol,
         favorites: FavoritesStoreProtocol ,
         initialQuery: String = "") {
        
        self.repo = repo
        self.favorites = favorites
        self.initialQuery = initialQuery
        
        self.favoriteItems = favorites.all()

        bindSearch()
        search(query: initialQuery, reset: true)
    }

    func toggleFavorite(_ book: Book) {
        favorites.toggle(book)
        favoriteItems = favorites.all()

        if let idx = allBooks.firstIndex(where: { $0.id == book.id }) {
            allBooks[idx].isFavorite.toggle()
        }
    }
    
    func removeFavorite(by id: String) {
        if let idx = allBooks.firstIndex(where: { $0.id == id }) {
            if allBooks[idx].isFavorite { allBooks[idx].isFavorite = false }
        }
        favorites.remove(id)
        favoriteItems = favorites.all()
    }

    func loadMoreIfNeeded(current book: Book?) {
        guard let book, book.id == allBooks.last?.id else { return }
        guard allBooks.count < total, !isLoading else { return }
        search(query: currentQuery, reset: false)
    }

    func retry() {
        search(query: currentQuery.isEmpty ? initialQuery : currentQuery, reset: allBooks.isEmpty)
    }
    

    private func bindSearch() {
        $searchText // Publisher
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } // شيل المسافات/الأسطر الزياد
            .removeDuplicates()
        // ينتظر 0.4 ثانيه بعد اخر حرف عشان ما نطلب طلب بعد كل ضغطه
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
         
            .sink { [weak self] q in
                guard let self else { return }
                let effective = q.isEmpty ? self.initialQuery : q // لو المستخدم مسح الحقل، نرجع لـ initialQuery
                self.search(query: effective, reset: true)
            }
            .store(in: &cancellables)
    }
    

    private func search(query: String, reset: Bool) {
        if reset {
            offset = 0; total = 0; allBooks = []; errorMessage = nil
            currentQuery = query
        }
        isLoading = true
        
        // اطلب صفحة نتائج من الريبو: (q, limit, offset)
        repo.search(q: query, limit: pageSize, offset: offset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                
                if case let .failure(err) = completion {
                    self.errorMessage = err.localizedDescription
                }
                
            } receiveValue: { [weak self] page in // نتيجه ناجحه، النتيجة اسمها page
                guard let self else { return }
                self.total = page.total

                let favIDs = Set(self.favoriteItems.map { $0.id })
                let mapped = page.items.map { item -> Book in
                    var b = item
                    b.isFavorite = favIDs.contains(b.id)
                    return b
                }

                self.allBooks.append(contentsOf: mapped)
                self.offset += mapped.count
            }
            .store(in: &cancellables)
    }
}
