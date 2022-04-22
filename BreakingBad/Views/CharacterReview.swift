//
//  CharacterReview.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import SwiftUI

struct CharacterReview: View {
    
    @StateObject private var reviewService: ReviewService // Initializing this here causes a Swift 6 warning because of the @MainActor
    
    @EnvironmentObject var reviewData: ReviewData
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var character: Character

    init(character: Binding<Character>) {
        _reviewService = StateObject(wrappedValue: ReviewService(networkAPI: NetworkAPI())) // Workaround to avoid Swift 6 warning
        self._character = character
    }
    
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
                    reviewService.submitReview(reviewData: reviewData)
                }) {
                    Text("Submit")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.orange)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.orange, lineWidth: 2)
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
        .alert(item: $reviewService.error) { error in
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
