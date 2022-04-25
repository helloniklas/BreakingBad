//
//  QuotesService.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Foundation
import Combine
import SwiftUI

class QuotesService: ObservableObject {
    private let networkAPI: NetworkAPI
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var error: NetworkAPI.Error? = nil
    @Published var quotes: [Quote]?

    init(networkAPI: NetworkAPI) {
        self.networkAPI = networkAPI
    }
    
    func fetchQuotes(character: Character) {
        quotes = nil
        networkAPI
            .fetchQuotesFor(character: character)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { quotes in
                withAnimation {
                    self.quotes = quotes
                    self.error = nil
                }
            }).store(in: &subscriptions)
    }
    
}
