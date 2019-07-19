//
//  Article.swift
//  RxNews
//
//  Created by Jason Sanchez on 7/9/19.
//  Copyright © 2019 Jason Sanchez. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

//extension ArticlesList {
//    static var all: Resource<ArticlesList> = {
//        let url = URL(string: NewsApi.baseUrl + "=" + NewsApi.apiKey)!
//        return Resource(url: url)
//    }()
//}

struct Article: Decodable {
    let title: String
    let description: String?
}
