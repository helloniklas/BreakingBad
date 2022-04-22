//
//  ReviewService.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import Foundation
import SwiftUI

@MainActor
class ReviewService: ObservableObject {
    private let networkAPI: NetworkAPI
    
    @Published var error: NetworkAPI.Error? {
        didSet {
            if error != nil {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }
    }
    
    @Published var isLoading = false

    init(networkAPI: NetworkAPI) {
        self.networkAPI = networkAPI
    }
    
    func submitReview(reviewData: ReviewData) {
        isLoading = true
        Task {
            do {
                try await networkAPI.submitReview(reviewData: reviewData)
            }
            catch {
                self.error = error as? NetworkAPI.Error
                isLoading = false
            }
        }
    }
    
}

