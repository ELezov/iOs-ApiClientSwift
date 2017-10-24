//
//  PlaceListViewControllerLocation.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 24.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

import CoreLocation

extension PlaceListViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation: CLLocation = locations[locations.count - 1]
        let latitude = latestLocation.coordinate.latitude
        let longitude = latestLocation.coordinate.longitude
        viewModel.updateDistanceToPlaces(latitude: latitude, longitude: longitude){ [weak self] () in
            self?.tableView.reloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
}

