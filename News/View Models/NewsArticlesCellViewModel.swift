//
//  NewsArticlesCellViewModel.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import Foundation

struct NewsArticleCellViewModel {
    let headline: String
    let theAbstract: String
    let byLine: String
    let imageUrl: String
    let url: String
    let timeStamp: Int
    
    init(newsArticle: NewsArticle) {
        headline = newsArticle.headline
        theAbstract = newsArticle.theAbstract
        byLine = "by \(newsArticle.byLine)"
        url = newsArticle.url
        timeStamp = newsArticle.timeStamp
        if let relatedImages = newsArticle.relatedImages,
            let thumbnailImage = relatedImages.filter({ $0.type == "thumbnail" }).first {
            imageUrl = thumbnailImage.url
        }
        else {
            imageUrl = ""
        }
    }
    
}
