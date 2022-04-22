//
//  DataStore.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Foundation


struct LikesDataStore: LikesDataStorable {
    
    static var likesKey = "Likes"
    
    func loadLikes() -> Array<Int> {
        return UserDefaults.standard.array(forKey: LikesDataStore.likesKey) as? Array<Int> ?? Array()
    }

    mutating func saveLike(characterID: Int, liked: Bool) {
        
        var likes = loadLikes()

        if liked {
            if let index = likes.firstIndex(of: characterID) {
                print(index)
            }
            else {
                likes.append(characterID)
                UserDefaults.standard.set(likes, forKey: LikesDataStore.likesKey)
            }
        }
        else {
            if let index = likes.firstIndex(of: characterID) {
                likes.remove(at: index)
                UserDefaults.standard.set(likes, forKey: LikesDataStore.likesKey)
            }
        }
    }
}

