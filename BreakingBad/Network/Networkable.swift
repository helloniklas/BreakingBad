//
//  Networkable.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 09/01/2021.
//

import Combine
import SwiftUI

protocol Networkable {
    func fetchCharacters() async throws -> [Character]
    
}
