//
//  NewsArticleCellViewModelTests.swift
//  NewsTests
//
//  Created by Alvis Mach on 13/3/21.
//

import XCTest

class NewsArticleCellViewModelTests: XCTestCase {
    var viewModel: NewsArticleCellViewModel!
    var newsArticle: NewsArticle!
    override func setUpWithError() throws {
        makeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testViewModelNotNil() {
        XCTAssertNotNil(viewModel)
    }
    
    func testViewModel_hasNewsUrl() {
        XCTAssertEqual(viewModel.url, newsArticle.url)
    }
    
    func testViewModel_hasHeadline() {
        XCTAssertEqual(viewModel.headline, newsArticle.headline)
    }
    
    func testViewModel_hasAbstract() {
        XCTAssertEqual(viewModel.theAbstract, newsArticle.theAbstract)
    }

    func testViewModel_hasByLine() {
        XCTAssertEqual(viewModel.byLine, newsArticle.byLine)
    }

    func testViewModel_hasNoThumbnailImageUrl() {
        XCTAssertNil(viewModel.imageUrl)
    }

    func testViewModel_hasTimeStamp() {
        XCTAssertEqual(viewModel.timeStamp, newsArticle.timeStamp)
    }

}

// MARK: - Helper
extension NewsArticleCellViewModelTests {
    private func makeViewModel() {
        newsArticle = NewsArticle(id: 1,
                                      url: "https://google.com.au",
                                      lastModified: 100,
                                      headline: "Breaking news",
                                      theAbstract: "Short description",
                                      byLine: "Michael Thomas",
                                      relatedImages: nil,
                                      timeStamp: 100)
        viewModel = NewsArticleCellViewModel(newsArticle: newsArticle)
    }
}
