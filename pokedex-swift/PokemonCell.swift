//
//  File.swift
//  pokedex-swift
//
//  Created by Maridalia Martinez on 8/3/23.
//

import Foundation
import SwiftUI

struct PokemonCell: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            ImageView(imageURL: pokemon.imageURL)
                .frame(width: 50, height: 50)
            
            Text(pokemon.name)
                .padding(.top, 4)
        }
    }
}
