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
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
