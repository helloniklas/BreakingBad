//
//  JSONDecoder+DateStrategy.swift
//  BreakingBad (iOS)
//
//  Created by Niklas Alvaeus on 25/04/2022.
//

import Foundation

extension JSONDecoder {
    static func api() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    static func apiddMMDDyyyy() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.MMddyyyy)
        return decoder
    }
    
    static func apiyyyyMMddHis() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yyyyMMddHis)
        return decoder
    }

}
