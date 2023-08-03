//
//  pokedex_swiftTests.swift
//  pokedex-swiftTests
//
//  Created by Maridalia Martinez on 8/3/23.
//

import XCTest
import SwiftUI

@testable import pokedex_swift

class pokedex_swiftTests: XCTestCase {
    var testHost: UIHostingController<PokemonView>!
    
    override func setUp() {
       super.setUp()
        
        let pokemonViewModel = PokemonViewModel(apiService: MockAPIService(pokemonData: mockPokemonData))
        let pokemonView = PokemonView(viewModel: pokemonViewModel)
        let testhost = UIHostingController(rootView: pokemonView)
        testHost.beginAppearanceTransition(true, animated: false)
        testHost.endAppearanceTransition()
    }

    override func tearDown() {
        testHost = nil
        super.tearDown()
    }

    let mockPokemonData: [Pokemon] = [
        Pokemon(name: "Pikachu", url: "https://example.com/pikachu.png"),
        Pokemon(name: "Charmander", url: "https://example.com/charmander.png")
    ]
        
    func testPokemonView() {
        let pokemonViewModel = PokemonViewModel(apiService: MockAPIService(pokemonData: mockPokemonData))
        let pokemonView = PokemonView(viewModel: pokemonViewModel)
        
        
        
        XCTAssertNotNil(testHost.view)
        XCTAssertTrue(testHost.view is UITableView)
    
        let tableView = testHost.view as!UITableView
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), mockPokemonData.count)
        
        for (index, pokemon) in mockPokemonData.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as? PokemonCell
            XCTAssertNotNil(cell)
            XCTAssertEqual(cell?.pokemonNameLable.text, pokemon.name)
            }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockAPIService: APIService {
    let pokemonData: [Pokemon]
    
    init(pokemonData: [Pokemon]) {
        self.pokemonData = pokemonData
    }
    
    func fetchPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        completion(pokemonData, nil)
    }
}


