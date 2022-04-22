//
//  Quote.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Foundation

struct Quote: Decodable, Identifiable {
    var id: Int
    var quote: String
    var author: String

    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case quote
        case author
    }
    
    static let sample = Self(id: 1, quote: "Lorem ipsum quote", author: "Niklas Alvaeus" )

}
