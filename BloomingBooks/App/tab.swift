//
//  tap.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 19/02/1447 AH.
//

import SwiftUI

struct RootTabView: View {
    //@StateObject private var vm = BooksListViewModel()
    @StateObject private var vm: BooksListViewModel
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    init() {
        let client: NetworkProtocol = Network()
        let repo: OpenLibraryRepositoryProtocol = OpenLibraryRepository(client: client)
        let favorites: FavoritesStoreProtocol = FavoritesStore()
        _vm = StateObject(wrappedValue: BooksListViewModel(repo: repo, favorites: favorites))
    }

    var body: some View {
        NavigationStack {
            TabView {
                BookListView(vm: vm)
                    .tabItem {
                        Image(systemName: "book.closed")
                        Text("Books")
                    }

                NavigationStack {
                    FavoritesView(vm: vm)
                }
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            }
        }
        .accentColor(.bloomingAccent)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
#Preview {
    RootTabView()
}
