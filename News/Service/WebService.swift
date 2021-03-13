//
//  WebService.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import Foundation

struct WebService: WebServiceProtocol {
    /*
     * News API Endpoint
     */
    private let apiUrl = "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full"
    
    /**
     * The shared singleton session object.
     */
    private let urlSession: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        urlSession = URLSession.init(configuration: config)
    }
        
    func fetchNews(completion: @escaping (Result<NewsModel?, WebServiceError>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(.failure(.badUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.httpError((error! as NSError).code)))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            do {
                let newsData = try JSONDecoder().decode(NewsModel.self, from: data)
                completion(.success(newsData))
            } catch {
                completion(.failure(.unknownJSONFormat))
            }
        }
        
        dataTask.resume()
    }
}

enum WebServiceError: Error {

    case noData
    case unknownJSONFormat
    case requestTimeout
    case noInternetConnection
    case httpError(Int)
    case customError(String)
    case unknownError
    case badData
    case badUrl
    
    var errorDetails: String {
        get {
            switch self {
            case .badData:
                return "Bad data"
            case .noData:
                return "No payload in response"
            case .unknownJSONFormat:
                return "The data format is incorret"
            case .requestTimeout:
                return "The newtork is too slow or no network, please try later"
            case .noInternetConnection:
                return "The Internet connection appears to be offline."
            case let .httpError(statusCode):
                switch statusCode {
                case 400:
                    return "request contains incorrect syntax."
                case 403:
                    return "Access to data is denied"
                case 404:
                    return "Could not found the required information online"
                case 500...510:
                    return "Server error"
                default:
                    return "An unknown error occured"
                }
            case let .customError(customErrorMessage):
                return customErrorMessage
            case .unknownError:
                return "An unknown error has occurred."
            case .badUrl:
                return "Bad url"
            }
        }
    }
}
