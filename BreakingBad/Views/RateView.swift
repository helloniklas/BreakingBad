//
//  RateView.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import SwiftUI

struct RateView: View {
    @Binding var rating: Int
    
    var body: some View {
        VStack {
            Text("Tap to rate:")
                .font(.headline)
                .padding(.bottom, 5)
            HStack {
                ForEach(1..<11) { index in
                    Button(action: { withAnimation { rating = index } }, label: {
                        if index >= rating + 1 {
                            Image(systemName: "star")
                        }
                        else {
                            Image(systemName: "star.fill")
                        }
                    })
                    .shadow(radius: 1)
                    .foregroundColor(.yellow)
                }
            }
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(rating: .constant(3))
    }
}
