//
//  QuotesView.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import SwiftUI

struct QuotesView: View {
    
    @EnvironmentObject private var quotesService: QuotesService

    var character: Character
    
    var body: some View {
        VStack {
            Text("Quotes")
                .font(.title2)
            
            if quotesService.error != nil {
                Text("Could not load quotes")
                    .font(.body)
                    .padding()
            }
            else if let quotes = quotesService.quotes {
                if quotes.isEmpty {
                    Text("No quotes available")
                        .font(.body)
                        .padding()
                }
                else {
                    VStack {
                        ForEach(quotes) { quote in
                            Text("”" + quote.quote + "“")
                                .font(.caption)
                                .italic()
                                .padding()
                        }
                        Spacer()
                            .frame(height: 50)
                    }
                }
            }
            else {
                ProgressView()
            }
        }
        .onAppear {
            quotesService.fetchQuotes(character: character)
        }
    }
}

struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView(character: Character.sample)
    }
}
