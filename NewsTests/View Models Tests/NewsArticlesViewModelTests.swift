//
//  NewsArticlesViewModelTests.swift
//  NewsArticlesViewModelTests
//
//  Created by Alvis Mach on 12/3/21.
//

import XCTest
@testable import News

class NewsArticlesViewModelTests: XCTestCase {
    var viewModel: NewsArticlesViewModel!
    var mockWebService: MockWebService!
    
    override func setUpWithError() throws {
        mockWebService = MockWebService()
        viewModel = NewsArticlesViewModel(webService: mockWebService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockWebService = nil
    }
    
    func testViewModel_canCallWebService() {
        viewModel.fetchNews { error  in
            
        }
        
        XCTAssertTrue(mockWebService.fetchServiceWasCalled)
    }
    
    func testViewModel_callWebService_returnError() {
        // Given
        mockWebService.networkCallFailed = true
        
        // When
        var networkError: Error?
        viewModel.fetchNews { (error) in
            networkError = error
        }
        
        // Then
        XCTAssertNotNil(networkError)
    }
    
    func testViewModel_callWebServiceSuccess_returnUnknownError() {
        // Given
        mockWebService.networkCallFailed = false
        mockWebService.shouldReturnEmptyData = true
        
        // When
        var networkError: WebServiceError?
        viewModel.fetchNews { (error) in
            networkError = error
        }
        
        // Then
        XCTAssertEqual(networkError?.errorDetails, WebServiceError.badData.errorDetails)
    }
    
    func testViewModel_callWebService_returnSuccess() {
        // Given
        mockWebService.networkCallFailed = false
        var success = false

        // When
        viewModel.fetchNews { error in
            success = (error == nil)
        }
        
        // Then
        XCTAssertTrue(success)
    }
    
    func testViewModel_callWebService_canParseJSONData() throws{
        // Given
        let exp = expectation(description: "Fetching news")
        
        // When
        makeSuccessWebServiceCall {
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(viewModel.newsArticleCellViewModels.count > 0)
    }
    
    func testViewModel_newsTitleNotEmpty() throws{
        // Given
        let exp = expectation(description: "Fetching news")
        
        // When
        makeSuccessWebServiceCall {
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(viewModel.title)
        XCTAssertTrue(viewModel.title!.count > 0)
    }

    func testViewModel_cellViewModel_hasNoImage() {
        // Given
        let exp = expectation(description: "Fetching news")
        
        // When
        makeSuccessWebServiceCall {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        let numberOfCellViewModelsMissingThumbnailImages = 1
        var numberOfCellViewModelsHaveThumbnailImages: Int = 0
        
        for cellViewModel in viewModel.newsArticleCellViewModels {
            if cellViewModel.imageUrl != nil && cellViewModel.imageUrl!.count > 0 {
                numberOfCellViewModelsHaveThumbnailImages += 1
            }
        }
        
        // Then
        XCTAssertEqual(numberOfCellViewModelsHaveThumbnailImages, viewModel.newsArticleCellViewModels.count - numberOfCellViewModelsMissingThumbnailImages)
    }
    
    func testViewModel_sortsCellViewModelsByTimeStamp() {
        // Given
        let exp = expectation(description: "Fetching news")
        
        // When
        makeSuccessWebServiceCall {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        // Then
        let firstCellViewModel = viewModel.newsArticleCellViewModels[0]
        let secondCellViewModel = viewModel.newsArticleCellViewModels[1]
        let thirdCellViewModel = viewModel.newsArticleCellViewModels[2]
        XCTAssertGreaterThanOrEqual(firstCellViewModel.timeStamp, secondCellViewModel.timeStamp)
        XCTAssertGreaterThanOrEqual(secondCellViewModel.timeStamp, thirdCellViewModel.timeStamp)
    }
}

// MARK: - Helper
extension NewsArticlesViewModelTests {
    private func makeSuccessWebServiceCall(completion: @escaping () -> Void) {
        mockWebService.networkCallFailed = false
        viewModel.fetchNews { error  in
            completion()
        }
    }
}
