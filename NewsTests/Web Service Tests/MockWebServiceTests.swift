//
//  MockWebServiceTests.swift
//  NewsTests
//
//  Created by Alvis Mach on 13/3/21.
//

import XCTest

class MockWebServiceTests: XCTestCase {
    var webService: MockWebService!

    override func setUpWithError() throws {
        webService = MockWebService()
    }

    override func tearDownWithError() throws {
        webService = nil
    }

    func testWebService_wasCalled() throws {
        webService.fetchNews { result in
            
        }
        XCTAssertTrue(webService.fetchServiceWasCalled)
    }

    func testMockNewsJSONDataExists() {
        XCTAssertNoThrow(try webService.getMockNewsJSONData())
    }
    
    func testWebService_returnError() {
        // Given
        webService.networkCallFailed = true
        
        // When
        var networkError: Error?
        webService.fetchNews { (result) in
            switch result {
            case .success:
                break
            case .failure(let error):
                networkError = error
            }
        }
        
        // Then
        XCTAssertNotNil(networkError)
    }
    
    func testWebService_returnEmptyData() {
        // Given
        webService.networkCallFailed = false
        webService.shouldReturnEmptyData = true

        // When
        var networkError: WebServiceError?
        webService.fetchNews { (result) in
            switch result {
            case .success:
                break
            case .failure(let error):
                networkError = error
            }
        }
        // Then
        XCTAssertEqual(networkError?.errorDetails, WebServiceError.badData.errorDetails)
    }
    
    func testWebService_returnSuccess() {
        // Given
        webService.networkCallFailed = false
        var success = false
        
        // When
        webService.fetchNews { result in
            switch result {
            case .failure:
                success = false
            case .success:
                success = true
            }
        }
        XCTAssertTrue(success)
    }
    
    func testWebService_canParseJSONData() throws{
        // Given
        webService.networkCallFailed = false
        let exp = expectation(description: "Fetching news")
        
        // When
        var newsModel: NewsModel?
        webService.fetchNews { result in
            switch result {
            case .success(let model):
                newsModel = model
            case .failure:
                break
            }
            exp.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(newsModel)
    }

}
