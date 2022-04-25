//
//  ReviewService.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Foundation
import SwiftUI

@MainActor
class ReviewService: ObservableObject {
    // MARK: Dependecies
    private let networkAPI: NetworkAPI

    // MARK: Published
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

    // MARK: Methods
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

