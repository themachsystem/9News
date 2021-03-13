//
//  NewsArticlesCellViewModel.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import Foundation

struct NewsArticleCellViewModel {
    var headline: String {
        return newsArticle.headline
    }
    
    var theAbstract: String {
        return newsArticle.theAbstract
    }
    
    var byLine: String {
        return newsArticle.byLine
    }
    
    var imageUrl: String {
        if let relatedImages = newsArticle.relatedImages,
            let thumbnailImage = relatedImages.filter({ $0.type == "thumbnail" }).first {
            return thumbnailImage.url
        }
        else {
            return ""
        }

    }
    var url: String {
        return newsArticle.url
    }
    var timeStamp: Int {
        newsArticle.timeStamp
    }
    
    private var newsArticle: NewsArticle

    init(newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
    }
    
    
}
