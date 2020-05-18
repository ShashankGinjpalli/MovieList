//
//  searchTableCell.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/6/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation
import UIKit

class searchTableCell:UITableViewCell{
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchMovieTitle: UILabel!
    @IBOutlet weak var addMovie: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        searchImage.layer.cornerRadius = 10
        addMovie.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 10
        
        customView.layer.cornerRadius = 5
        
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width:0.5, height:4.0);
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 5.0 //Here your control your blur
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    }
    
    
}
