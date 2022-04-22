//
//  CharacterDetail.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import SwiftUI

struct CharacterDetail: View {
    @EnvironmentObject private var characterService: CharacterService
    
    @Binding var character: Character
    
    @StateObject private var reviewData = ReviewData()
    
    @State private var isShowingReview = false
    
    private let generatorSelection = UISelectionFeedbackGenerator()

    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack {
                GeometryReader { geometry in
                    // Keep all this here to avoid if statements, which would cauase rerender
                    HeroImageView(imageUrl: URL(string: character.img),
                                  size: geometry.frame(in: .global).minY <= 0 ?
                                  CGSize(width: geometry.size.width, height: geometry.size.height) : CGSize(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY))
                    .offset(y: geometry.frame(in: .global).minY <= 0 ?
                            0 : -geometry.frame(in: .global).minY)
                }
                .frame(height: 350)
                
                HStack {
                    Text(character.name).font(.title)
                    Button(action: { toggleLike() }, label: {
                        LikeIcon(isLiked: character.isLiked)
                    })
                }
                .padding()
                
                QuotesView(character: character)
                
                Spacer()
            }
            .navigationBarItems(trailing:
                                    Button("Create Review") {
                isShowingReview = true
            }
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $isShowingReview) {
            CharacterReview(character: $character).environmentObject(reviewData)
        }
    }
    
    private func toggleLike() {
        characterService.toggleLike(character: character)
        generatorSelection.selectionChanged()
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: Binding.constant(Character.sample))
            .environmentObject(CharacterService(networkAPI: NetworkAPI(), dataStore: LikesDataStore()))
    }
}
