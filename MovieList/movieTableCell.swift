//
//  movieTableCell.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/2/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation
import UIKit

class movieTableCell:UITableViewCell{
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var markWatchedButton: UIButton!
    
    
    
    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
        customView.layer.cornerRadius = 20
        movieTitle.clipsToBounds = true
        movieTitle.layer.cornerRadius = 15
        movieImage.layer.cornerRadius = 7
        
        customView.layer.shadowColor = UIColor.black.cgColor
        customView.layer.shadowOffset = CGSize(width:0.5, height:4.0);
        customView.layer.shadowOpacity = 0.3
        customView.layer.shadowRadius = 5.0 //Here your control your blur
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
