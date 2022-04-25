//
//  CharacterService.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import SwiftUI

@MainActor
class CharacterService: ObservableObject {
    
    // MARK: Dependecies
    private let networkAPI: Networkable
    private var dataStore: LikesDataStorable
    
    // MARK: Published
    @Published var error: NetworkAPI.Error? = nil
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var animateIn = false
    
    init(networkAPI: Networkable, dataStore: LikesDataStorable) {
        self.networkAPI = networkAPI
        self.dataStore = dataStore
    }

    // MARK: Methods
    func fetchCharacters() {
        isLoading = true
        
        Task {
            do {
                let charactersFromRemote = try await networkAPI.fetchCharacters()
                let likes = dataStore.loadLikes()
                let charactersWithLikes = charactersFromRemote.map { (item: Character) -> Character in
                    if likes.firstIndex(of: item.id) != nil {
                        var characterWithLike = item
                        characterWithLike.isLiked = true
                        return characterWithLike
                    }
                    else {
                        return item
                    }
                }
                characters = charactersWithLikes
                isLoading = false
                error = nil
                withAnimation(Animation.easeInOut(duration: 0.6)) {
                    animateIn = true
                }
            }
            catch {
                self.error = error as? NetworkAPI.Error
                isLoading = false
            }
        }
    }
    
    func toggleLike(character: Character) {
        if character.isLiked {
            unlike(character: character)
        }
        else {
            like(character: character)
        }
    }
    
    // MARK: Private Methods
    private func like(character: Character) {
        if let index = characters.firstIndex(where: { $0.id == character.id }) {
            dataStore.saveLike(characterID: character.id, liked: true)
            characters[index].isLiked = true
        }
    }
    
    private func unlike(character: Character) {
        if let index = characters.firstIndex(where: { $0.id == character.id }) {

            dataStore.saveLike(characterID: character.id, liked: false)
            characters[index].isLiked = false
        }
    }

}
