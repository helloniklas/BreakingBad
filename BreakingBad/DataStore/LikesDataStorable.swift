//
//  LikesDataStorable.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Foundation

protocol LikesDataStorable {
    mutating func saveLike(characterID: Int, liked: Bool)
    func loadLikes() -> Array<Int>
}
