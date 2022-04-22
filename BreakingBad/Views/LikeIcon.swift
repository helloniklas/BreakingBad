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
        Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
            .foregroundColor(.green)
    }
}

struct LikeIcon_Previews: PreviewProvider {
    static var previews: some View {
        LikeIcon(isLiked: true)
    }
}
