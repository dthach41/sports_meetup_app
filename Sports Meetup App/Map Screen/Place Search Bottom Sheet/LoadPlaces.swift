//
//  LoadPlaces.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 12/7/24.
//

import Foundation
import CoreLocation
import MapKit

extension MapViewController{
    
    func loadPlacesAround(query: String){
        
        let notificationCenter = NotificationCenter.default
        
        var mapItems = [MKMapItem]()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query


        // Set the region to an associated map view's region.
        searchRequest.region = mapView.mapView.region


        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                // Handle the error.
                return
            }
            mapItems = response.mapItems
            
            for item in response.mapItems {
                if let name = item.name,
                    let location = item.placemark.location {
                    print("\(name), \(location)")
                }
            }
            
            notificationCenter.post(name: .placesFromMap, object: mapItems)
        }
    }
}
