//
//  BooksListViewModel.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 19/02/1447 AH.
//

import Foundation

class BooksListViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var allBooks: [Book] = [
        Book(title: "It Ends With Us",
             author: "Colleen Hoover",
             subtitle: "A guide to building good habits and breaking bad ones.",
             coverName: "ItEndWithUs",
             isFavorite: false),
        
        Book(title: "Atomic HabitThe Stolen Girls",
             author: "Patricia Gibney",
             subtitle: "A gripping thriller where Detective Lottie Parker investigates a chilling crime.",
             coverName: "TheStolenGirls",
             isFavorite: true),
        
        Book(title: "It Starts With Us",
             author: "Colleen Hoover",
             subtitle: "The highly anticipated sequel about new beginnings and second chances.",
             coverName: "ItStartWithUs",
             isFavorite: false),
        
        Book(title: "Us Against You",
             author: "Fredrik Backman",
             subtitle: "A heart-wrenching story of community, loyalty, and survival in a small town.",
             coverName: "UsAgainstYou",
             isFavorite: true),
        
        Book(title: "FreeWill",
             author: "Sam Harrid",
             subtitle: "Detective Lucy Black faces a dangerous case that tests her courage and skills.",
             coverName: "FreeWill",
             isFavorite: true)
    ]
    
    /*
     ببحث عن اول اندكس يحقق الشرط
     كل عنص ر يمر على الكلوجر يمثل كتاب 0 من allBooks
     اقارن الاي دي الخاص فيه مع الاي دي المرر للفنكشن
     firstIndex(where:) -> return Int? - if let
     اذا لقيت الكتاب 
     */
    
    func toggleFavorite(_ book: Book) {
        if let idx = allBooks.firstIndex(where: { $0.id == book.id }) {
            allBooks[idx].isFavorite.toggle()
        }
    }
    
    
    var filteredBooks: [Book] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return allBooks }
        return allBooks.filter {
            $0.title.localizedCaseInsensitiveContains(q)
//            || $0.author.localizedCaseInsensitiveContains(q)
//            || $0.subtitle.localizedCaseInsensitiveContains(q)
        }
    }
    

//    func updateSearch(_ text: String) {
//        searchText = text
//    }
}

extension BooksListViewModel {
    static var preview: BooksListViewModel {
        let vm = BooksListViewModel()
        vm.allBooks = [
            Book(title: "Atomic Habits", author: "James Clear",
                 subtitle: "A guide to building good habits and breaking bad ones.",
                 coverName: "ItEndWithUs", isFavorite: true),
            Book(title: "Deep Work", author: "Cal Newport",
                 subtitle: "Rules for focused success in a distracted world.",
                 coverName: "deep_work", isFavorite: false),
        ]
        return vm
    }
}
