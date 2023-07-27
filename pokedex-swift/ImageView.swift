//
//  ImageView.swift
//  pokedex-swift
//
//  Created by Maridalia Martinez on 7/20/23.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    let imageURL: String
    
    init(imageURL: String) {
            self.imageURL = imageURL
            imageLoader.fetchImage(from: imageURL)
        }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    imageLoader.fetchImage(from: imageURL)
                }
        } else {
            EmptyView()
        }
    }
}
