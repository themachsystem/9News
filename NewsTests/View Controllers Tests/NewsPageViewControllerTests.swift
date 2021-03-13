//
//  NewsPageViewControllerTests.swift
//  NewsTests
//
//  Created by Alvis Mach on 13/3/21.
//

import XCTest
@testable import News

class NewsPageViewControllerTests: XCTestCase {
    var sut: NewsPageViewController!
    override func setUpWithError() throws {
        makeSUT()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSUT_notNit() {
        XCTAssertNotNil(sut)
    }
    
    func testSUT_initViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testSUT_hasViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testSUT_hasWebView() {
        XCTAssertNotNil(sut.webView)
    }
    
    func testSUT_hasValidNewsUrl() {
        let newsUrl = URL(string: sut.viewModel.newsUrl)
        XCTAssertNotNil(newsUrl)
    }
}

// MARK: - Helper
extension NewsPageViewControllerTests {
    private func makeSUT() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "NewsPageViewController") as? NewsPageViewController
        sut.viewModel = News.NewsPageViewModel(newsTitle: "News title", newsUrl: "https://google.com.au")
    }
}
