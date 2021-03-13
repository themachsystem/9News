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
        
    func fetchNews(completion: @escaping (Result<NewsModel?, Error>) -> Void) {
        let url = URL(string: apiUrl)!
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                // The request went through but something wrong happened that we received no data response.
                let unknownError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "An unknown error has occurred."])
                completion(.failure(unknownError))
                return
            }
            do {
                let newsData = try JSONDecoder().decode(NewsModel.self, from: data)
                completion(.success(newsData))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
