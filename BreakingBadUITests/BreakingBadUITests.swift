//
//  BreakingBadUITests.swift
//  BreakingBadUITests
//
//  Created by Niklas Alvaeus on 22/04/2022.
//

import XCTest

class BreakingBadUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterTitleSucess() throws {
        app.tables.cells["Henry Schrader"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        XCTAssertTrue(app.staticTexts["Henry Schrader"].exists)
    }
}
