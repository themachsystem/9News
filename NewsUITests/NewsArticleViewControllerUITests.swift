//
//  NewsArticleViewControllerUITests.swift
//  NewsArticleViewControllerUITests
//
//  Created by Alvis Mach on 12/3/21.
//

import XCTest

class NewsArticleViewControllerUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkCallFails_showsErrorMessage() {
        configureEnvironmentMockFailedNetworkCall()
        app.launch()
        let retryButton = app.alerts["Network Error!"].scrollViews.otherElements.buttons["Retry"]
        XCTAssertTrue(retryButton.exists)
    }
    
    func testNetworkCallFails_tableViewEmpty() {
        configureEnvironmentMockFailedNetworkCall()
        app.launch()
        let tableView = app.tables["newsTableView"]
        let numberOfRows = tableView.children(matching: .cell).count
        XCTAssertEqual(numberOfRows, 0)
    }

    func testNetworkCallSuccess_tableViewNotEmpty() {
        app.launch()
        let tableView = app.tables["newsTableView"]
        let numberOfRows = tableView.children(matching: .cell).count
        XCTAssertGreaterThan(numberOfRows, 0)
    }

    func testTapNewsArticle_showsWebView() {
        app.launch()
        let tableView = app.tables["newsTableView"]
        let firstCell = tableView.cells["cell_0"]
        firstCell.tap()
        
        let webView = app.webViews["newsWebView"]
        XCTAssertTrue(webView.exists)
    }
    
    func testTapNewsArticle_showsWebView_hasNewsTitleInNavigationTitle() {
        app.launch()
        let tableView = app.tables["newsTableView"]
        let firstCell = tableView.cells["cell_0"]
        let newsHeadlineLabel = firstCell.staticTexts["HeadlineLabel"]
        let newsTitle = newsHeadlineLabel.label
        firstCell.tap()
        
        let navigationBar = app.navigationBars[UITestingConfig.AccessibilityIdentifier.webViewNavigationTitle]
        let navigationTitle = navigationBar.children(matching: .staticText).firstMatch.label
        XCTAssertEqual(navigationTitle, newsTitle)
    }

}

extension NewsArticleViewControllerUITests {
    /**
     * Mocks failed network call
     */
    private func configureEnvironmentMockFailedNetworkCall() {
        app.launchArguments += [UITestingConfig.kShouldMockNetworkCall]
        app.launchEnvironment[UITestingConfig.kNetworkCallShouldFail] = "true"
    }
}
