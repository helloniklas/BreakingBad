//
//  CharacterReview.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import SwiftUI

struct CharacterReview: View {
    
    @StateObject static private var reviewService = ReviewService(networkAPI: NetworkAPI()) // Static olves the Swift 6 warning for @MainActor
    
    @EnvironmentObject var reviewData: ReviewData
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var character: Character

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Review of \(character.name)")
                    .font(.title)
                HStack {
                    Text("Your name:")
                        .font(.headline)
                    TextField("Type your name...", text: $reviewData.name)
                }
                DatePicker("Date watched:", selection: $reviewData.date)
                Text("Write your review:")
                    .font(.headline)
                TextEditor(text: $reviewData.text)
                    .foregroundColor(.gray)
                    .frame(height: 300)
                    .border(Color.gray, width: 1)
                RateView(rating: $reviewData.rating)
                .padding()
                Spacer()
                Button(action: {
                    guard self.reviewData.isValid else { return }
                    CharacterReview.reviewService.submitReview(reviewData: reviewData)
                }) {
                    Text("Submit")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                .buttonStyle(AnimateSelectionStyle())
                .disabled(!reviewData.isValid)
                .opacity(reviewData.isValid ? 1.0 : 0.5)

                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                .buttonStyle(AnimateSelectionStyle())
            }
            .padding()
        }
        .alert(item: CharacterReview.$reviewService.error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct CharacterReview_Previews: PreviewProvider {
    static var previews: some View {
        CharacterReview(character: Binding.constant(Character.sample))
            .environmentObject(ReviewData())
    }
}
