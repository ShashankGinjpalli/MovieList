//
//  coreDataFuncs.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/21/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation
import CoreData

class coreDataFuncs {
    
    func getAllRecords(obj: NSManagedObjectContext) -> [Any]{
        
        var results:[Any] = []
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "MovieObj",in: obj)
        let request: NSFetchRequest<MovieObj> = MovieObj.fetchRequest() as! NSFetchRequest<MovieObj>
        request.entity = entityDescription
        
        do {
            results =
                try obj.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            
        }
        catch let error {
            print("Error")
        }
        
        return results
        
    }
    
    func deleteCoreDataObject (obj: NSManagedObjectContext, movieContainer: movie){
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "MovieObj",
                                       in: obj)
        let request: NSFetchRequest<MovieObj> = MovieObj.fetchRequest() as! NSFetchRequest<MovieObj>
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(movieTitle = %@)",movieContainer.movieTitle ?? "")
        request.predicate = pred
        
        do {
            var results =
                try obj.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                obj.delete(match)
                try obj.save()
                
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error)
        }
    }
    
    
    func addCoreDataEntity(obj: NSManagedObjectContext, movieContainer:movie){
        let ent = NSEntityDescription.entity(forEntityName: "MovieObj", in: obj)
        let movieCell = MovieObj(entity: ent!, insertInto: obj)
        movieCell.movieTitle = movieContainer.movieTitle
        movieCell.moviePoster = movieContainer.moviePoster
        movieCell.movieDirector = movieContainer.movieDirector
        movieCell.movieReleaseDate = movieContainer.movieReleaseDate
        movieCell.movieRating = movieContainer.movieRating
        movieCell.movieCast = movieContainer.movieCast
        movieCell.movieWebRatings = movieContainer.movieWebRatings
        movieCell.moviePlot = movieContainer.movieOverView;
        
        
        do {
            try obj.save()
            
            
            print("Success")
            
        } catch let error {
            print(error)
        }
        
    }
    
    func editData (obj: NSManagedObjectContext, movieContainer:movie){
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "MovieObj",
                                       in: obj)
        let request: NSFetchRequest<MovieObj> = MovieObj.fetchRequest() as! NSFetchRequest<MovieObj>
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(movieTitle = %@)",movieContainer.movieTitle ?? "")
        request.predicate = pred
        
        do {
            var results =
                try obj.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                match.setValue(movieContainer.moviePoster, forKey: "moviePoster")
                
                try obj.save()
                
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error)
        }
    }
    
}


