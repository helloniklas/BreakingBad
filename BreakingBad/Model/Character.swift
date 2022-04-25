//
//  Character.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Foundation

struct Character: Decodable, Identifiable, Comparable {
    
    var id: Int
    var name: String
    var birthday: String // TODO: API returns a date string "dd-MM-yyyy or a string of "unknown". Needs to work with multiple value types when decoded
    var occupation: [String]
    var img: String
    var status: String
    var appearance: [Int]?
    var nickname: String
    var portrayed: String
    var isLiked = false
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case img
        case status
        case appearance
        case nickname
        case portrayed
    }
    
    mutating func setLike() {
        isLiked = true
    }
    
    static func < (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
    static let sample = Self(id: 1, name: "Niklas", birthday: "01-01-1973", occupation: ["iOS Engineer"], img: "test", status: "Occupied", appearance: nil, nickname: "Niklas", portrayed: "Home" )

}

