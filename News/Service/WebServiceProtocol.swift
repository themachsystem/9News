//
//  WebServiceProtocol.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import Foundation

protocol WebServiceProtocol {
    
    /**
     * Fetches news from the API and calls a handler upon completion.
     */
    func fetchNews(completion: @escaping (Result<NewsModel?, Error>) -> Void)
}
