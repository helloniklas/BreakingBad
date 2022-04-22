//
//  HeroImageView.swift
//  BreakingBad (iOS)
//
//  Created by Niklas Alvaeus on 22/04/2022.
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

struct HeroImageView_Previews: PreviewProvider {
    static var previews: some View {
        HeroImageView(imageUrl: URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"), size: CGSize(width: 300, height: 200))
    }
}
