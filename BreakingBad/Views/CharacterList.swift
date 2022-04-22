//
//  CharacterList.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import SwiftUI

struct CharacterList: View {
    @EnvironmentObject private var characterService: CharacterService
    
    var body: some View {
        NavigationView {
            if characterService.isLoading {
                ProgressView()
            }
            else if let error = characterService.error {
                VStack {
                    Text(error.localizedDescription)
                        .padding()
                    Button(action: { characterService.fetchCharacters() }) {
                        Text("Try again")
                    }
                }
            }
            else {
                List(characterService.characters) { character in
                    NavigationLink(destination: CharacterDetail(character: binding(for: character))) {
                        HStack {
                            Text(character.name)
                            Spacer()
                            LikeIcon(isLiked: character.isLiked)
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.characterService.toggleLike(character: character)
                                }
                        }
                    }
                }
                .navigationTitle("Characters")
            }
        }
        .onAppear {
            characterService.fetchCharacters()
        }
    }
    
    private func binding(for character: Character) -> Binding<Character> {
        guard let characterIndex = characterService.characters.firstIndex(where: { $0 == character }) else {
            fatalError("Can't find character in array")
        }
        return $characterService.characters[characterIndex]
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        // TODO: Make a sample static data for preview...
        CharacterList()
            .environmentObject(CharacterService(networkAPI: NetworkAPI(), dataStore: LikesDataStore()))
    }
}
