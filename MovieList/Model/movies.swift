//
//  movies.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/2/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation



class movies{
    
    
    var movies:[movie] = []
    
    func getMovie(item: Int) -> movie{
        return movies[item];
    }
    
    func getCount() -> Int {
        return movies.count;
    }
    
    func addMovie(m:movie){
        movies.append(m);
    }
    
    func removeMovie(item: Int){
        movies.remove(at: item);
    }
    
    func editMovie(newImage:Data, index:Int){
        movies[index].moviePoster = newImage;
    }
    
    func callApi(m:movie) -> movie{
        
        var temp = m
        
        var urlAsString = "https://www.omdbapi.com/?apikey=fb0e46f5&"
        var title = m.movieTitle;
        title = title!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        urlAsString = urlAsString + "t=" + title!
        print(urlAsString)
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let sem = DispatchSemaphore(value: 0)
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            
            var err: NSError?
            
            
            let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
         
            let results = jsonResult as! [String:AnyObject]
            print(results)
            
            if(results["Response"] as! String == "True"){
         
                temp.movieOverView = results["Plot"] as! String
                temp.movieRunTime = results["Runtime"] as? String
                temp.movieReleaseDate = results["Released"] as! String
                temp.movieBoxOffice = results["BoxOffice"] as! String
                temp.movieCast = results["Actors"] as! String
                
                let rate = results["Ratings"] as! NSMutableArray
                for i in rate{
                    let y = i as! [String:String]
                    let src = y["Source"] as! String
                    let val = y["Value"] as! String
                    
                    temp.movieWebRatings = (temp.movieWebRatings ?? "") + src + ": " + val + "\n"
                    
                }
                
                temp.movieRating = results["Rated"] as! String
                
                temp.movieDirector = results["Director"] as! String
                
            }
            else{
                temp.movieOverView = "Not Found"
                temp.movieRunTime = "Not Found"
                temp.movieReleaseDate = "Not Found"
                temp.movieBoxOffice = "Not Found"
                temp.movieCast = "Not Found"
//                temp.movieWebRatings = []
                temp.movieWebRatings = "Not Found"
                
                temp.movieRating = "Not Found"
                
                temp.movieDirector = "Not Found"
            }
            
            sem.signal()
        })
        
        
        jsonQuery.resume()
        let _ = sem.wait(timeout: .now() + 10.0)
        
        

       
        return temp
        
    }
    
}


class movie{
    var movieTitle:String?
    var movieOverView:String?
    var movieRunTime: String?
    var movieReleaseDate: String?
    var movieBoxOffice:String?
    var movieCast:String?
    
    var movieWebRatings:String?
    var movieRating:String?
    var movieDirector:String?;
    var moviePoster: Data?
    
    init(title:String, img:Data) {
        self.movieTitle = title;
        self.moviePoster = img;
        
        // poll the first api for the image
        
        // poll the api for the data
    }
    
   
    
}


