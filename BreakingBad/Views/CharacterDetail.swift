//
//  CharacterDetail.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetail: View {
    @EnvironmentObject private var characterService: CharacterService
    
    @Binding var character: Character
    
    @StateObject private var reviewData = ReviewData()
    
    @State private var isShowingReview = false
    
    var body: some View {
        VStack {
            
            WebImage(url: URL(string: character.img))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .clipShape(Circle())
                .shadow(radius: 5)
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
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
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $isShowingReview) {
            CharacterReview(character: $character).environmentObject(reviewData)
        }
    }
    
    private func toggleLike() {
        self.characterService.toggleLike(character: character)
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: Binding.constant(Character.sample))
            .environmentObject(CharacterService(networkAPI: NetworkAPI(), dataStore: LikesDataStore()))
    }
}
