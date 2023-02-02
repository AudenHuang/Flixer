//
//  MovieCollectionViewController.swift
//  flixster
//
//  Created by Auden Huang on 2/1/23.
//

import UIKit
import Nuke

class MovieCollectionViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    var movies = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        MovieCollectionView.delegate = self
        MovieCollectionView.dataSource = self
        
        let layout = MovieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        
        let width = (MovieCollectionView.bounds.width - layout.minimumInteritemSpacing * 2) / 5
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=dfaa3fb7c1543c45ced1c29e12293102")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String: Any]]
                
                self.MovieCollectionView.reloadData()
           }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.item]
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        Nuke.loadImage(with: posterURL!, into: cell.PosterImage)
        
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

        let cell = sender as! UICollectionViewCell
        let indexPath = MovieCollectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
    
        let detailViewController = segue.destination as! MovieDetailViewController
        detailViewController.movie = movie
    
        MovieCollectionView.deselectItem(at: indexPath, animated: true)
    }

}
