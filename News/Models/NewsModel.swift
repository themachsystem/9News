//
//  NewsData.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import Foundation

/**
 * Constructed from JSON response from API
 */
struct NewsModel: Decodable {
    let id: Int
    let displayName: String
    let lastModified: Int
    let assets: [NewsArticle]
}

struct NewsArticle: Decodable {
    let id: Int
    let url: String
    let lastModified: Int
    let headline: String
    let theAbstract: String
    let byLine: String
    var relatedImages: [RelatedImage]?
    let timeStamp: Int
}

struct RelatedImage: Decodable {
    let id: Int
    let url: String
    let type: String
}
