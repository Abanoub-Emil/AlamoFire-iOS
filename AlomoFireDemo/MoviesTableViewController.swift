//
//  MoviesTableViewController.swift
//  AlomoFireDemo
//
//  Created by Champion on 5/19/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
class MoviesTableViewController: UITableViewController {
    var movies=[Movie]()
    let url = "https://api.androidhive.info/json/movies.json"
    
    let requestManager = AlamoFireManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        if movies.count==0
        {
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
                        
                        self.reloadTableData(moves: self.movies)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let movie = movies[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string:movie.image!), placeholderImage: UIImage(named:"loading.png"))
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "\(String(describing: movie.rate!)) / 10"

        return cell
    }
    
    func reloadTableData(moves:[Movie]){
        self.movies = moves
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select row at index path
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailController = storyBoard.instantiateViewController(withIdentifier: "detailsView") as! ViewController
        detailController.movieDetail = movies[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
