//
//  DetailedView.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/2/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation

import UIKit

class DetailedView: UIViewController {
    
    var movieObject:movie?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieCast: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRelease: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreButton.layer.cornerRadius = 15
        movieImage.layer.cornerRadius = 15
        movieImage.image = UIImage(data: movieObject?.moviePoster ?? Data());
        movieTitle.text = movieObject?.movieTitle ?? ""
        movieDirector.text = movieObject?.movieDirector ?? "Not Found"
        movieCast.text = movieObject?.movieCast ?? "Not Found"
        movieRating.text = movieObject?.movieRating ?? "N/A"
        movieRelease.text = movieObject?.movieReleaseDate ?? "Not Found"
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "Details"){
            
            if let viewController: moreDetailedView = segue.destination as? moreDetailedView {
                viewController.movieObject = self.movieObject
            }
        }
        
        if(segue.identifier == "Editview"){
            if let viewController: EditView = segue.destination as? EditView {
                viewController.movieImageDat = self.movieObject?.moviePoster
            }
        }
    }
    
    @IBAction func unwindToDetailedView(segue: UIStoryboardSegue) {
        if let sourceView = segue.source as? EditView {
            self.movieObject?.moviePoster = sourceView.movieImage.image?.jpegData(compressionQuality: 1.0);
            self.movieImage.image = UIImage(data: sourceView.movieImage.image?.jpegData(compressionQuality: 1.0) ?? Data())
            
        }
    }
    
    
}
