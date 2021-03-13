//
//  NewsArticlesViewModel.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import Foundation

class NewsArticlesViewModel {
    private let webService: WebServiceProtocol
    
    private(set) var newsArticleCellViewModels: [NewsArticleCellViewModel] = []
    
    var title: String?
    
    init(webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }
    
    func fetchNews(completion: @escaping (_ error: Error?) -> Void) {
        webService.fetchNews {[weak self] result in
            var fetchError: Error?
            defer {
                completion(fetchError)
            }
            switch result {
            case .success(let newsData):
                if let newsData = newsData {
                    self?.title = newsData.displayName
                    // Sorts the articles by timeStamp, descending.
                    self?.createCellViewModels(with: newsData.assets)
                }
            case .failure(let error):
                fetchError = error
            }
        }
    }
    
    /**
     * Creates view models and sorts them by descending time stamp
     */
    private func createCellViewModels(with newsData: [NewsArticle]) {
        for news in newsData {
            let cellViewModel = NewsArticleCellViewModel(newsArticle: news)
            newsArticleCellViewModels.append(cellViewModel)
        }
        newsArticleCellViewModels.sort { $0.timeStamp > $1.timeStamp }
    }
}
