//
//  MapView.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/2/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation();
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035))
            self.map.setRegion(region, animated: true)
            
            
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Movie Theater"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print( response.mapItems )
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                
                let coordinates = CLLocationCoordinate2D( latitude: (place.location?.coordinate.latitude)!, longitude: (place.location?.coordinate.longitude)!)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = place.name
                
                self.map.addAnnotation(annotation)
                
            }
            
        }
        
        
    }
    
    
}
