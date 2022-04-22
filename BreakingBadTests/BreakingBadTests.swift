//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import XCTest
@testable import BreakingBad

class BreakingBadTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReviewDataSuccess() throws {

        // If
        let reviewData = ReviewData()

        // When
        reviewData.date = Date()
        reviewData.name = "Niklas"
        reviewData.rating = 10
        reviewData.text = "Lorem ipsum"
        
        // Then
        XCTAssertTrue(reviewData.isValid)
    }

    func testReviewDataFail() throws {

        // If
        let reviewData = ReviewData()

        // When
        reviewData.date = Date()
        reviewData.rating = 10
        reviewData.text = "Lorem ipsum"
        
        // Then
        XCTAssertFalse(reviewData.isValid)
    }
    

    @MainActor func testCharacterService() throws {
        
        let characterService = CharacterService(networkAPI: MockNetworkAPI(), dataStore: LikesDataStore())
        characterService.fetchCharacters()
        
        
        characterService.toggleLike(character: Character.sample)
        
        let expectation = expectation(description: "Test after 1 seconds")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(characterService.characters.count == 1)
        }
        else {
            XCTFail("Delay interrupted")
        }
        
    }
    
    @MainActor func testCharacterToggleLikeSuccess() throws {
        
        // If
        let characterService = CharacterService(networkAPI: MockNetworkAPI(), dataStore: MockLikesDataStore())
        characterService.fetchCharacters()
        
        let expectation = expectation(description: "Test after 1 seconds")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            // When
            characterService.toggleLike(character: Character.sample)
            if let character = characterService.characters.first(where: { $0.id == Character.sample.id }) {
                // Then
                XCTAssertTrue(character.isLiked)
            }
            else {
                XCTFail("No characters")
            }
            
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    @MainActor func testCharacterToggleLikeFail() throws {
        
        // If
        let characterService = CharacterService(networkAPI: MockNetworkAPI(), dataStore: MockLikesDataStore())
        characterService.fetchCharacters()
        
        let expectation = expectation(description: "Test after 1 seconds")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            // When
            if let character = characterService.characters.first(where: { $0.id == Character.sample.id }) {
                // Then
                XCTAssertFalse(character.isLiked)
            }
            else {
                XCTFail("No characters")
            }
            
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
}

class MockNetworkAPI: Networkable {
    func fetchCharacters() async throws -> [Character] {
        return [Character.sample]
    }
}

struct MockLikesDataStore: LikesDataStorable {
    
    var likes: Array<Int> = Array()
    
    mutating func saveLike(characterID: Int, liked: Bool) {
        if liked {
            if let index = likes.firstIndex(of: characterID) {
                print(index)
            }
            else {
                likes.append(characterID)
            }
        }
        else {
            if let index = likes.firstIndex(of: characterID) {
                likes.remove(at: index)
            }
        }
    }
    
    func loadLikes() -> Array<Int> {
        return likes
    }
}

