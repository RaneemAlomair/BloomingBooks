//
//  tap.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 19/02/1447 AH.
//

import SwiftUI

struct RootTabView: View {
    @StateObject private var vm = BooksListViewModel()
    
    // singleton class to save dark mode useing app storage
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var body: some View {
        NavigationStack {
            TabView {
                BookListView( vm: vm)
                
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
        
    }
}

#Preview {
    RootTabView()
}
