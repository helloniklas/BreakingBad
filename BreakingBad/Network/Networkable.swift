//
//  Networkable.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Combine
import SwiftUI

protocol Networkable {
    func fetchCharacters() async throws -> [Character]
    
}
