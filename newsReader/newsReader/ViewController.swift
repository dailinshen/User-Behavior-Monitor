//
//  ViewController.swift
//  newsReader
//
//  Created by lindashen on 1/9/17.
//  Copyright © 2017 lindashen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!

    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles()
    }

    func fetchArticles() {
    
        // new york time:   160 * 90
        // https://newsapi.org/v1/articles?source=the-new-york-times&sortBy=top&apiKey=4fd46387a9f1413e8e2a07fd8911a0ec
        // bbc news:
        // https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=4fd46387a9f1413e8e2a07fd8911a0ec
        // THe Reuters:    135 * 90
        // https://newsapi.org/v1/articles?source=reuters&sortBy=top&apiKey=4fd46387a9f1413e8e2a07fd8911a0ec
        let urlRequest = URLRequest(url: URL(string:"https://newsapi.org/v1/articles?source=reuters&sortBy=top&apiKey=4fd46387a9f1413e8e2a07fd8911a0ec")!) //      ! is used to unwrap sth.
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, reponse, error) in
            
            // data is for JSON, response is for the answer, error is for if there is sth happens
            
            // we would like to check if there is an error or not
            if error != nil {
                print(error)
                return
            }
            
            self.articles = [Article]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]  // This gives us a dictionary of things.
                if let articlesFromJson = json["articles"] as? [[String: AnyObject]] {
                    for each_articleFromJson in articlesFromJson {
                        let article = Article()
                        if let author = each_articleFromJson["author"] as? String, let desc = each_articleFromJson["description"] as? String, let title = each_articleFromJson["title"] as? String, let imgtourl = each_articleFromJson["urlToImage"] as? String, let url = each_articleFromJson["url"] as? String {
                            article.author = author
                            article.headline = title
                            article.imgurl = imgtourl
                            article.text = desc
                            article.url = url
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.sync {
                    self.TableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        cell.Title.text = self.articles?[indexPath.item].headline
        cell.Description.text = self.articles?[indexPath.item].text
        cell.Author.text = self.articles?[indexPath.item].author
        cell.ImgView.downloadImage(from: (self.articles?[indexPath.item].imgurl!)!)
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0  // if self.articles?.count == nil use 0, else use itself
    }
    
    
    // PART 3
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Web_View_Constroller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController // "web" is the identity of storyboard ID
        
        Web_View_Constroller.url = self.articles?[indexPath.item].url
        
        Web_View_Constroller.story_title = (self.articles?[indexPath.item].headline)!
        
        self.present(Web_View_Constroller, animated: true, completion: nil)
        
    }
    
}

extension UIImageView {
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            // here, data is the image
            
            // check if there is an error or not
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.sync {
                //self.image is the UIImageView Extension
                self.image = UIImage(data: data!)
            }
        }
        // to fire the task
        task.resume()
    }
}















