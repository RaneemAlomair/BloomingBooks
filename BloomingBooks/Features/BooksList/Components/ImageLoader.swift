//
//  ImageLoader.swift
//  BloomingBooks
//
//  Created by Raneem Alomair on 10/03/1447 AH.
//
//import UIKit
//import Combine
//// async image 
// class ImageLoader: ObservableObject {
//    @Published var image: UIImage?
//    private var cancellable: AnyCancellable?
//    private static let cache = NSCache<NSURL, UIImage>()
//
//    func load(_ url: URL?) {
//        guard let url = url else { self.image = nil; return }
//        if let cached = Self.cache.object(forKey: url as NSURL) {
//            self.image = cached
//            return
//        }
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .replaceError(with: nil) // فشل الصور ما يخرب الواجهة
//            .handleEvents(receiveOutput: { img in
//                if let img { Self.cache.setObject(img, forKey: url as NSURL) }
//            })
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.image, on: self) // يرجّع AnyCancellable
//    }
//
//    func cancel() { cancellable?.cancel() }
//}
//
