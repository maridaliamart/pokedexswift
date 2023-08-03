//
//  File.swift
//  pokedex-swift
//
//  Created by Maridalia Martinez on 8/3/23.
//

import Foundation

protocol APIService {
    
    func fetchPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void)
    
}
