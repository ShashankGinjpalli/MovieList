//
//  ViewController.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 10/30/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cdf:coreDataFuncs = coreDataFuncs();
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var m:movies = movies()
    @IBOutlet weak var movieTable: UITableView!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let results = cdf.getAllRecords(obj: managedObjectContext);
        
        for i in results{
            let match = i as! NSManagedObject
//            print(match.value(forKey: "movieTitle"))
//
//            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            var temp = movie(title: match.value(forKey: "movieTitle") as! String, img: match.value(forKey: "moviePoster") as! Data)
            temp.movieCast = match.value(forKey: "movieCast") as? String
            temp.movieReleaseDate = match.value(forKey: "movieReleaseDate") as? String
            temp.movieRating = match.value(forKey: "movieRating") as? String
            temp.movieWebRatings = match.value(forKey: "movieWebRatings") as? String
            temp.movieOverView = match.value(forKey: "moviePlot") as? String
            temp.movieDirector = match.value(forKey: "movieDirector") as? String

            m.addMovie(m: temp);
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m.getCount();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDataCell", for: indexPath) as! movieTableCell
        
        let movieItem = m.getMovie(item:indexPath.row)
        cell.movieImage.image = UIImage(data: movieItem.moviePoster!);
        cell.movieTitle.text = movieItem.movieTitle!
        cell.movieRating.text = movieItem.movieRating ?? "N/A";
        
        cell.markWatchedButton.tag = indexPath.row
        
        cell.markWatchedButton.addTarget(self, action: #selector(deleteButton(_:)), for: .touchUpInside)
        
        return cell;
    }
    
    @objc func deleteButton(_ sender: UIButton){
        let index = sender.tag
        
        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you would like to remove this movie from your watchlist?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { action in
            var temp = self.m.getMovie(item: index)
            self.cdf.deleteCoreDataObject(obj: self.managedObjectContext, movieContainer: temp);
            self.m.removeMovie(item: index)
            self.movieTable.reloadData();
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "Overview"){
            let selectedIndex: IndexPath = self.movieTable.indexPath(for: sender as! UITableViewCell)!
            if let viewController: DetailedView = segue.destination as? DetailedView {
                viewController.movieObject = m.getMovie(item: selectedIndex.row)
                index = selectedIndex.row
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.movieTable.indexPathForSelectedRow{
            self.movieTable.deselectRow(at: index, animated: true)
        }
        
    }
    
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let sourceView = segue.source as? AddView {
            
            var mov = movie(title: sourceView.searchObject.searchTitle!, img: sourceView.searchObject.imageDat ?? Data())
            mov = m.callApi(m: mov)
            m.addMovie(m: mov)
            
            cdf.addCoreDataEntity(obj: managedObjectContext, movieContainer: mov)
            
            self.movieTable.reloadData()
        }
        
        if let sourceView = segue.source as? DetailedView {
            m.editMovie(newImage: sourceView.movieImage.image?.jpegData(compressionQuality: 1.0) ?? Data(), index: index)
            cdf.editData(obj: managedObjectContext, movieContainer: m.getMovie(item: index))
            self.movieTable.reloadData()
        }
    }
    
}

