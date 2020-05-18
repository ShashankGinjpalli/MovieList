//
//  Movie+CoreDataClass.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/21/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    
    @NSManaged public var movieTitle: String?
    @NSManaged public var moviePoster: Data?
    @NSManaged public var movieDirector: String?
    @NSManaged public var movieCast: String?
    @NSManaged public var movieRating: String?
    @NSManaged public var movieReleaseDate: String?
    @NSManaged public var moviePlot: String?
    @NSManaged public var movieWebRatings: String?
    
}
