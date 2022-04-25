//
//  NetworkAPI.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 21/04/2022.
//

import Combine
import SwiftUI

struct NetworkAPI: Networkable {
    
    // MARK: Enums
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }

        case serverError
        case parseError
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "There was a problem reaching the server. Please try again"
            case .parseError:
                return "There was a problem. Please try again"
            }
        }
    }
    
    // MARK: Private Enums
    private enum Method: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case patch = "PATCH"
        case put = "PUT"
    }
    
    private enum EndPoint {
        static let baseURL = URL(string: "https://www.breakingbadapi.com/api")!
        
        case characters
        case quotes
        case review
        
        var url: URL {
            switch self {
            case .characters:
                return EndPoint.baseURL.appendingPathComponent("/characters")
            case .quotes:
                return EndPoint.baseURL.appendingPathComponent("/quote")
            case .review:
                return EndPoint.baseURL.appendingPathComponent("/review")
            }
        }
        
        static func request(with url: URL, method: Method, params: [String: Any]? = nil) -> URLRequest {
            var components = URLComponents(string: url.absoluteString)!
            if method == .get || method == .delete || method == .patch {
                if let params = params {
                    components.queryItems = params.map {
                        URLQueryItem(name: $0.key, value: String(describing: $0.value))
                    }
                }
            }
            var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
            request.httpMethod = method.rawValue
            if let params = params {
                switch method {
                case .post, .patch, .put:
                    request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
                default:
                    break
                }
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
    
    // MARK: Private properties
    private let decoder = JSONDecoder.apiddMMDDyyyy()
    private let urlSession = URLSession.shared

    
    // MARK: Methods
    // This is using await/async
    func fetchCharacters() async throws -> [Character] {
        let (data, response) = try await urlSession.data(for: EndPoint.request(with: EndPoint.characters.url, method: .get))

        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            throw Error.serverError
        }

        guard let characters = try? decoder.decode([Character].self, from: data) else {
            throw Error.parseError
        }

        return characters
    }
    
    // This is using Combine
    func fetchQuotesFor(character: Character) -> AnyPublisher<[Quote], Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.request(with: EndPoint.quotes.url, method: .get, params: ["author": character.name]))
            .map { return $0.data }
            .decode(type: [Quote].self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.serverError
                default:
                    return Error.parseError
                }
            }
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func submitReview(reviewData: ReviewData) async throws  -> Void {
        // No review end point exists, so simulate an error
        throw Error.serverError
    }
    
}
