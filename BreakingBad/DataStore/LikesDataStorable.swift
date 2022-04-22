//
//  LikesDataStorable.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import Foundation

protocol LikesDataStorable {
    mutating func saveLike(characterID: Int, liked: Bool)
    func loadLikes() -> Array<Int>
}
