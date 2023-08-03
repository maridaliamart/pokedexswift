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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    let mockPokemonData: [Pokemon] = [
        Pokemon(name: "Pikachu", url: "https://example.com/pikachu.png"),
        Pokemon(name: "Charmander", url: "https://example.com/charmander.png")
    ]
        
    func testPokemonView() {
        let pokemonViewModel = PokemonViewModel(apiService: MockAPIService(pokemonData: mockPokemonData))
        let pokemonView = PokemonView(viewModel: pokemonViewModel)
        
        let testhost = UIHostingController(rootView: pokemonView)
        testHost.beginAppearanceTransition(true, animated: false)
        testHost.endAppearanceTransition()
        
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


