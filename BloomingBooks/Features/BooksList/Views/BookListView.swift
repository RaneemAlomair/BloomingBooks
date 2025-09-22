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
    
    private var isInitialLoading: Bool {
        vm.isLoading && vm.allBooks.isEmpty && vm.errorMessage == nil
    }

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

                    List {
                        Section {
                            ForEach(vm.allBooks) { book in
                                NavigationLink {
                                    BookDetailView(vm: vm, book: book)
                                } label: {
                                    BookRowView(book: book, vm: vm)
                                }
                                .listRowBackground(Color.bloomingBackground)
                                .onAppear { vm.loadMoreIfNeeded(current: book) }
                            }

                            // loading row (same section)
                            if vm.isLoading && !vm.allBooks.isEmpty {
                                HStack { Spacer(); ProgressView(); Spacer() }
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.bloomingBackground)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)

                    
                    .overlay(alignment: .center) {
                        if isInitialLoading {
                            VStack(spacing: 12) {
                                ProgressView().scaleEffect(1.3)
                                Text("Loading books…")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                
                ErrorCardView(vm: vm)
                
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
