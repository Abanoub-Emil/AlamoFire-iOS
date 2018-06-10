//
//  AlamoFireManager.swift
//  AlomoFireDemo
//
//  Created by Champion on 5/19/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage
class AlamoFireManager {

    var movies=[Movie]()
    func requestData(url:String){
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success( _):
                
                do {let json = try? JSON(data: response.data!)
                    for object in (json?.arrayValue)!{
                        let movie = Movie()
                        movie.title = object["title"].stringValue
                        movie.image = object["image"].stringValue
                        movie.rate = object["rating"].doubleValue
                        self.movies.append(movie)
                    }
                   let tableView = MoviesTableViewController()
                    tableView.reloadTableData(moves: self.movies)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
