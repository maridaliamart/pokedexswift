//
//  ContentView.swift
//  pokedex-swift
//
//  Created by Maridalia Martinez on 7/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Pokeverse | All Pokemon")
                .font(.title)
                .fontWeight(.bold)
            //PokedexImageView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
