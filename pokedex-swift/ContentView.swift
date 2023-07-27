//
//  ContentView.swift
//  pokedex-swift
//
//  Created by Maridalia Martinez on 7/20/23.
//

import SwiftUI

struct Pokemon: Codable {
    let name: String
    let url: String
    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(url.split(separator: "/").dropLast().last!).png"
    }
}
 
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    //adding a completion closure that gets called when data's fetched
    func fetchPokemonData(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            if let data = data {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonList = result.results
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        } else if let error = error {
            print("Error fetching data: \(error)")
        }
        }.resume()
    }
}

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

//adding state management for handling loading
struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var isLoading = false
    
    var body: some View {
        NavigationView{
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            ForEach(viewModel.pokemonList, id: \.name) { pokemon in
                                VStack {
                                    ImageView(imageURL: pokemon.imageURL)
                                        .frame(width: 50, height: 50)
                                    Text(pokemon.name)
                                        .padding(.top, 4)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokemon List")
        }
        .onAppear {
            isLoading = true
            viewModel.fetchPokemonData {
                isLoading = false
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
