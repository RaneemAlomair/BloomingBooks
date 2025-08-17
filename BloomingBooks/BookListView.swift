//
//  BookListView.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 11/02/1447 AH.
//

import SwiftUI


struct BookListView: View {
    var backgroundColor = Color.bloomingBackground
    
    @ObservedObject var vm: BooksListViewModel
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Blooming Books 🌼")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.bloomingText)
                    
                    HStack {
                        TextField("Search Books...", text: $vm.searchText)
                            .padding()
                            .background(Color.bloomingCard)
                            .cornerRadius(10)
                            .foregroundColor(.bloomingText)
                            .font(.headline)
                        
                        Button {
                            withAnimation(.easeInOut) {
                                isDarkMode.toggle()
                            }
                        } label: {
                            Circle()
                                .fill(.bloomingCard)
                                .frame(width: 55 ,height: 55)
                                .overlay(
                                    Image(systemName:isDarkMode ? "sun.max.fill" : "moon.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.bloomingAccent)
                                )
                        }
                    }
                 //   vm.allBooks
                    List {
                        ForEach(vm.filteredBooks) { book in
                            NavigationLink {
                                BookDetailView(vm: vm, book: book)
                            } label: {
                                BookRowView(book: book, vm: vm)
                            }
                            .listRowBackground(Color.bloomingBackground)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}


struct BookRowView: View {
    let book: Book
    @ObservedObject var vm: BooksListViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image((book.coverName ?? ""))
                .resizable()
                .frame(width: 80, height: 110)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.bloomingText)
                
                Text(book.author)
                    .foregroundColor(.gray)
                
                Text(book.subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
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

