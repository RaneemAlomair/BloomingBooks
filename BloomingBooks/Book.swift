//
//  Book.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 16/02/1447 AH.
//
import Foundation
// Model
struct Book: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let author: String
    let subtitle: String
    let coverName: String?
    var isFavorite: Bool = false
}

