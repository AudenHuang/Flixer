//
//  MovieDetailViewController.swift
//  flixster
//
//  Created by Auden Huang on 1/30/23.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var BackdropImage: UIImageView!
    
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var VoteAverage: UILabel!
    @IBOutlet weak var VoteCount: UILabel!
    @IBOutlet weak var Popularity: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieTitle.text = movie["original_title"] as? String
        Description.text = movie["overview"] as? String
        let count = movie["vote_count"] as? Int
        VoteCount.text = "\(Int(count!)) Votes"
        let avg = movie["vote_average"] as? Double
        VoteAverage.text = "\(Double(avg!)) Vote Average"
        let pop = movie["popularity"] as? Double
        Popularity.text = "\(Double(pop!)) Popularity"
        
        
        //posterView.af.setImage(withURL: posterURL!)
        
        let baseBackdropURL = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseBackdropURL + backdropPath)
        
        
        Nuke.loadImage(with:backdropURL!, into: BackdropImage)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
