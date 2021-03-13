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

}

// MARK: - Helper
extension NewsPageViewControllerTests {
    private func makeSUT() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NewsPageViewController") as? UINavigationController
        sut = navigationController?.topViewController as? NewsPageViewController
    }
}
