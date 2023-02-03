//
//  MovieTableViewCell.swift
//  flixster
//
//  Created by Auden Huang on 2/1/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieDescription: UILabel!
    @IBOutlet weak var PosterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
