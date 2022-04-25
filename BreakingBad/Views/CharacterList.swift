//
//  CharacterList.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import SwiftUI

struct CharacterList: View {

    @EnvironmentObject private var characterService: CharacterService
    private let generatorSelection = UISelectionFeedbackGenerator()

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
                        CharacterRow(name: character.name, isLiked: character.isLiked) {
                            self.characterService.toggleLike(character: character)
                            generatorSelection.selectionChanged()
                        }
                    }
                }
                .opacity(characterService.animateIn ? 1 : 0)
                .offset(x: 0, y: characterService.animateIn ? 0 : 50)
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

struct CharacterRow: View {
    
    var name: String
    var isLiked: Bool
    var likeClosure: () -> Void
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            LikeIcon(isLiked: isLiked)
                .padding(.trailing, 20)
                .onTapGesture {
                    likeClosure()
                }
        }
    }
    
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        let tmp = CharacterService(networkAPI: NetworkAPI(), dataStore: LikesDataStore())
        
        CharacterList()
            .environmentObject(tmp)

        CharacterRow(name: "Niklas", isLiked: true, likeClosure: {})

        CharacterRow(name: "Niklas", isLiked: true, likeClosure: {})
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
            .previewDisplayName("iPhone SE (1st generation)")

    }
}



