//
//  CharacterDetail.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeroImageView: View {
    
    var imageUrl: URL?
    var size: CGSize
    
    var body: some View {
        WebImage(url: imageUrl)
            .resizable()
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .transition(.fade(duration: 0.5))
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .clipped()
            .overlay(
                VStack {
                    Spacer()
                    Rectangle().fill(LinearGradient(colors: [Color(UIColor.systemBackground), .clear], startPoint: .bottom, endPoint: .top))
                        .frame(height: 200)
                }
            )
    }
    
}


struct CharacterDetail: View {
    @EnvironmentObject private var characterService: CharacterService
    
    @Binding var character: Character
    
    @StateObject private var reviewData = ReviewData()
    
    @State private var isShowingReview = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
        VStack {
            GeometryReader { geometry in
                if geometry.frame(in: .global).minY <= 0 {
                    HeroImageView(imageUrl: URL(string: character.img), size: CGSize(width: geometry.size.width, height: geometry.size.height))
                }
                else {
                    HeroImageView(imageUrl: URL(string: character.img), size: CGSize(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY))
                        .offset(y: -geometry.frame(in: .global).minY)
                }
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
        self.characterService.toggleLike(character: character)
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: Binding.constant(Character.sample))
            .environmentObject(CharacterService(networkAPI: NetworkAPI(), dataStore: LikesDataStore()))
    }
}
