//
//  MapViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 12/7/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    let mapView = MapView()
    
    let locationManager = CLLocationManager()
    
    let notificationCenter = NotificationCenter.default
    
    var currLocation = ""
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.buttonCurrentLocation.addTarget(self, action: #selector(onButtonCurrentLocationTapped), for: .touchUpInside)
        
        setupLocationManager()
        
        //MARK: center the map view to current location when the app loads...
        onButtonCurrentLocationTapped()
        
        mapView.buttonSearch.addTarget(self, action: #selector(onButtonSearchTapped), for: .touchUpInside)
    }
    
    @objc func onButtonCurrentLocationTapped() {
        if let currentLocation = locationManager.location {
            mapView.mapView.centerToLocation(location: currentLocation)
        } else {
            print("Current location is not available.")
            // Optionally, set a default location
            let defaultLocation = CLLocation(latitude: 42.340431, longitude: -71.088928) // Example: San Francisco
            mapView.mapView.centerToLocation(location: defaultLocation)
        }
        mapView.buttonLoading.isHidden = true
    }
    
    
    
    @objc func onButtonSearchTapped(){
        
        //MARK: Setting up bottom search sheet...
        let searchViewController  = SearchViewController()
        searchViewController.delegateToMapView = self
        
        let navForSearch = UINavigationController(rootViewController: searchViewController)
        navForSearch.modalPresentationStyle = .pageSheet
        
        if let searchBottomSheet = navForSearch.sheetPresentationController{
            searchBottomSheet.detents = [.medium(), .large()]
            searchBottomSheet.prefersGrabberVisible = true
        }
        
        present(navForSearch, animated: true)
    }

    
    func showSelectedPlace(placeItem: MKMapItem) {
        let coordinate = placeItem.placemark.coordinate
        mapView.mapView.centerToLocation(
            location: CLLocation(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
        )
        let place = Place(
            title: placeItem.name!,
            coordinate: coordinate,
            info: placeItem.description
        )
        mapView.mapView.removeAnnotations(mapView.mapView.annotations)
        mapView.mapView.addAnnotation(place)
        currLocation = placeItem.name!
        
        // notifies to update the address/location for creating new event
        notificationCenter.post(name: .addressForNewEvent, object: currLocation)
    }
}


extension MKMapView{
    func centerToLocation(location: CLLocation, radius: CLLocationDistance = 1000){
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        setRegion(coordinateRegion, animated: true)
    }
}




