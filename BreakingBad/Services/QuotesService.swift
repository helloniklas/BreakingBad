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
    
    // MARK: Dependecies
    private let networkAPI: NetworkAPI
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Published
    @Published var error: NetworkAPI.Error? = nil
    @Published var quotes: [Quote]?

    init(networkAPI: NetworkAPI) {
        self.networkAPI = networkAPI
    }
    
    // MARK: Methods
    func fetchQuotes(character: Character) {
        quotes = nil
        networkAPI
            .fetchQuotesFor(character: character)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] quotes in
                withAnimation {
                    self?.quotes = quotes
                    self?.error = nil
                }
            }).store(in: &subscriptions)
    }
    
}
