//
//  ViewController.swift
//  rx_sample
//
//  Created by 石垣駿 on 2018/09/10.
//  Copyright © 2018年 石垣駿. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.request().subscribe(onNext: { (articles) in
            print(articles)
            self.articles = articles
            self.tableView.reloadData()
            
        }, onError: { (error) in
            print(error)
            
        }, onCompleted: {
            print("onComplete")
            
        }, onDisposed: {
            print("onDisposed")
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func request() -> Observable<[Article]> {
        return Observable.create { (observer: AnyObserver<[Article]>) in
            Alamofire.request(Strings.api).responseArray() { (response: DataResponse<[Article]>) in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = self.articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.user?.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
}

