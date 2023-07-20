//
//  ContentView.swift
//  pokedex-swift
//
//  Created by Maridalia Martinez on 7/20/23.
//

import SwiftUI

struct Pokemon: Identifiable, Codable {
    var id = UUID()
    let name: String
    let url: String
    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(url.split(separator: "/").dropLast().last!).png"
    }
}
 
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    
    func fetchPokemonData() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in if let data = data {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(PokemonListResponse.self, from data)
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

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(viewModel.pokemonList) { pokemon in VStack {
                    ImageView(imageURL: pokemon.imageURL)
                        .frame(width: 50, height: 50)
                    Text(pokemon.name)
                        .padding(.top, 2)
                }
                }
            }
        }
        .onAppear {
            viewModel.fetchPokemonData()
        }
        .navigationTitle("Pokemon List")
        
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
