//
//  MovieListViewController.swift
//  flixster
//
//  Created by Auden Huang on 1/30/23.
//

import UIKit
import Nuke

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var MovieTableView: UITableView!
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieTableView.dataSource = self
        MovieTableView.delegate = self

        // Do any additional setup after loading the view.
        //movies = MoviesResponse.loadJson()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=dfaa3fb7c1543c45ced1c29e12293102")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.MovieTableView.reloadData()
           }
        }
        task.resume()
        
//        for movie in movies {
//            //print(movie.original_title)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! MovieTableViewCell
        let movie = movies[indexPath.row]
        let title = movie["original_title"] as! String
        let description = movie["overview"] as! String

        cell.MovieTitle.text = title
        cell.MovieTitle.sizeToFit()
        cell.MovieDescription.text = description
        cell.MovieDescription.sizeToFit()


        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        Nuke.loadImage(with:posterURL!, into:cell.PosterImage)

        return cell
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        let cell = sender as! UITableViewCell
        let indexPath = MovieTableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
    
        let detailViewController = segue.destination as! MovieDetailViewController
        detailViewController.movie = movie
    
        MovieTableView.deselectRow(at: indexPath, animated: true)
    }

}
