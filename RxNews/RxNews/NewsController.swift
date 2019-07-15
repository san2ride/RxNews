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
    
    let bag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else {
            fatalError("ArticleCell does not exist")
        }
        
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descriptionLabel.text = self.articles[indexPath.row].description
        
        return cell
    }
    
    private func populateNews() {
        
        //let resource = Resource<ArticlesList>(url: url)
        
        URLRequest.load(resource: ArticlesList.all)
            /*
            .subscribe(onNext: { articleResponse in
                let articles = articleResponse?.articles
                self.articleListVM = ArticleListViewModel(articles)
                
                
                
            }).disposed(by: bag)
            */
        
            
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: bag)
    }
}
