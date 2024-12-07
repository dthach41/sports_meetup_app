//
//  SearchViewController.swift
//  Sports Meetup App
//
//  Created by Derek Thach on 12/7/24.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {

    let searchBottomSheet = SearchBottomSheet()

    var delegateToMapView: MapViewController!
    
    var mapItems = [MKMapItem]()
    //codes omitted...
    
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = searchBottomSheet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBottomSheet.tableViewSearchResults.delegate = self
        searchBottomSheet.tableViewSearchResults.dataSource = self
        searchBottomSheet.searchBar.delegate = self
        
        searchBottomSheet.tableViewSearchResults.separatorStyle = .none
        
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationForPlaces(notification:)),
            name: .placesFromMap,
            object: nil
        )
        
    }
    
    
    @objc func notificationForPlaces(notification: Notification){
        mapItems = notification.object as! [MKMapItem]
        self.searchBottomSheet.tableViewSearchResults.reloadData()
    }
    
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegateToMapView.loadPlacesAround(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.searchTableViewID, for: indexPath) as! MapSearchTableViewCell
        if let name = mapItems[indexPath.row].name{
                cell.labelTitle.text = name
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegateToMapView.showSelectedPlace(placeItem: mapItems[indexPath.row])
        self.dismiss(animated: true)
    }
    
}

