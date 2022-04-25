//
//  ReviewData.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Combine
import SwiftUI

class ReviewData: ObservableObject {
    
    // MARK: Published
    @Published var isValid: Bool = false
    
    @Published var date: Date = Date() {
        didSet {
            validate()
        }
    }
    
    @Published var name: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published var text: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published var rating: Int = 0 {
        didSet {
            validate()
        }
    }
    
    // MARK: Private Methods
    private func validate() {
        if name.count > 0 && text.count > 0 && rating != 0 {
            isValid = true
        }
        else {
            isValid = false
        }
    }
    
}


