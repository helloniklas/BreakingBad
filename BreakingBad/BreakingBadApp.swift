//
//  BreakingBadApp.swift
//  Shared
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import SwiftUI

@main
struct BreakingBadApp: App {
    
    private let characterService: CharacterService
    private let quotesService = QuotesService(networkAPI: NetworkAPI())

    init() {
        characterService = CharacterService(networkAPI: NetworkAPI(), dataStore: LikesDataStore()) // Solves the Swift 6 warning for @MainActor
    }
    
    var body: some Scene {
        WindowGroup {
            CharacterList()
                .environmentObject(characterService)
                .environmentObject(quotesService)
        }
    }
}
