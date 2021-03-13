//
//  MockWebService.swift
//  NewsTests
//
//  Created by Alvis Mach on 13/3/21.
//

import Foundation

final class MockWebService {
    var networkCallFailed = false
    var shouldReturnEmptyData = false
    var fetchServiceWasCalled = false
        
    /**
     * Reads the local JSON file which is just a static JSON mocked from News API.
     *
     * The JSON file has been modified that it removed the thumbnail image data for the first news article so we can easily test the case when a news article has no thumbnail image.
     */
    func getMockNewsJSONData() throws -> Data {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "MockNewsData", ofType: "json") else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"MockNewsData.json not found"])
        }
        guard let jsonString = try? String(contentsOfFile: filePath, encoding: .utf8) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Unable to convert MockNewsData.json to String"])
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Unable to convert MockNewsData.json to Data"])
        }
        return jsonData
    }
}

extension MockWebService: WebServiceProtocol {
    func fetchNews(completion: @escaping (Result<NewsModel?, Error>) -> Void) {
        fetchServiceWasCalled = true
        if !networkCallFailed {
            if shouldReturnEmptyData {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"An unknown error has occurred."])))
            }
            else {
                do {
                    let newsJSONData = try self.getMockNewsJSONData()
                    let newsModel = try JSONDecoder().decode(NewsModel.self, from: newsJSONData)
                    completion(.success(newsModel))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        }
    }
}
