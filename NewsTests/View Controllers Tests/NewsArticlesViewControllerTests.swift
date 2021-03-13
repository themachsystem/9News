//
//  NewsArticlesViewControllerTests.swift
//  NewsTests
//
//  Created by Alvis Mach on 13/3/21.
//

import XCTest
@testable import News

class NewsArticlesViewControllerTests: XCTestCase {
    var sut: NewsArticlesViewController!
    override func setUpWithError() throws {
        makeSUT()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSUT_notNil() {
        XCTAssertNotNil(sut)
    }
    
    func testSUT_hasNavigationController() {
        XCTAssertNotNil(sut.navigationController)
    }
    
    func testSUT_hasTableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testSUT_hasActivityIndicator() {
        XCTAssertNotNil(sut.activityIndicator)
    }
    
    func testSUT_canShowLoadingActivityIndicator() {
        sut.showLoadingIndicator()
        XCTAssertTrue(sut.activityIndicator.isAnimating)
    }
    
    func testSUT_canDismissLoadingActivityIndicator() {
        sut.dismissLoadingIndicator()
        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }

    func testSUT_hasViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
    
}

// MARK: - Helper
extension NewsArticlesViewControllerTests {
    private func makeSUT() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NewsNavigationViewController") as? UINavigationController
        sut = navigationController?.topViewController as? News.NewsArticlesViewController
    }
}
