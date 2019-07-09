//
//  NewsController.swift
//  RxNews
//
//  Created by Jason Sanchez on 7/9/19.
//  Copyright © 2019 Jason Sanchez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func populateNews() {
        
        let url = URL(string: NewsApi.baseUrl + "=" + NewsApi.apiKey)!
        
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> [Article]? in
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
            }.subscribe(onNext: { articles in
                
                if let articles = articles {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
    }
}
