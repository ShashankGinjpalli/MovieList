//
//  moreDetailedView.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/20/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation
import UIKit

class moreDetailedView:UIViewController{
    
    var movieObject:movie?
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    var str = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        plotLabel.layer.cornerRadius = 15
        ratingsLabel.layer.cornerRadius = 15
        plot.layer.cornerRadius = 15
        ratings.layer.cornerRadius = 15
        
        
        plot.text = movieObject?.movieOverView ?? "Not Found"
        
        let ratings = movieObject?.movieWebRatings ?? "Not Found"
        
//        for i in ratings{
//            var temp = ""
//            temp = i.src! + ": " + i.value! + "\n"
//            str = str + temp
//        }
        
        self.ratings.text  = ratings
        
    }
    
    
    
}
