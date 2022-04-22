//
//  LikeIcon.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import SwiftUI

struct LikeIcon: View {
    var isLiked: Bool
    
    var body: some View {
        Image(systemName: isLiked ? "heart.fill" : "heart")
            .foregroundColor(.red)
    }
}

struct LikeIcon_Previews: PreviewProvider {
    static var previews: some View {
        LikeIcon(isLiked: true)
    }
}
