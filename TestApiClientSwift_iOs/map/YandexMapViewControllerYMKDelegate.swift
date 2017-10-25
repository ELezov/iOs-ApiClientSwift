//
//  YandexMapViewControllerYMKDelegate.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension YandexMapViewController: YMKMapViewDelegate, YMKLocationFetcherDelegate {
    
    public func locationFetcher(_ locationFetcher: YMKLocationFetcher!, didFailWithError error: Error!) {
        print("Location Fetcher", error.localizedDescription)
    }

    func startMonitoringLocationFetching() {
        locationFetcher.addObserver(self, forKeyPath: "fetchingLocation", options: [], context: nil)
    }
    
    func stopMonitoringLocationFetching() {
        locationFetcher.removeObserver(self, forKeyPath: "fetchingLocation")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if  (keyPath == "fetchingLocation") {
            updateFetchingLocationUI()
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change as! [NSKeyValueChangeKey : Any]?, context: context)
        }
    }
    
    func setupLocateMeButton(forFetchingStatus isFetchingLocation: Bool) {
        if isFetchingLocation {
            locateMeBtn.setImage(nil, for: .normal)
            locateMeBtn.setImage(nil, for: .highlighted)
        }
        else {
            locateMeBtn.setImage(UIImage(named: "LocateMe"), for: .normal)
            locateMeBtn.setImage(UIImage(named: "LocateMeHighlighted"), for: .highlighted)
        }
    }
    
    func updateFetchingLocationUI() {
        setupLocateMeButton(forFetchingStatus: locationFetcher.isFetchingLocation)
        scrollToUserLocation()
    }
    
    
    //YMKFetchDelegate
    
    func locationFetcherDidFetchUserLocation(_ locationFetcher: YMKLocationFetcher!) {

    }
    
    func scrollToUserLocation() {
        let userLocation: CLLocation? = self.yandexMapView.userLocation.location
        self.yandexMapView.setCenter((userLocation?.coordinate)!, animated: true)
    }
    
    func locationFetcher(_ locationFetcher: YMKLocationFetcher) throws {
        
    }
    
    // YMKMapViewDelegate
    func mapView(_ mapView: YMKMapView!, viewFor annotation: YMKAnnotation!) -> YMKAnnotationView! {
        let id = "pointAnnotation"
        var point: YMKPinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as! YMKPinAnnotationView
        point = YMKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
        point.canShowCallout = true
        self.configureAnnotationView(view: point)
        return point
    }
    
    func mapView(_ mapView: YMKMapView!, calloutViewFor annotation: YMKAnnotation!) -> YMKCalloutView! {
        let id = "pointCallout"
        var callout: YMKDefaultCalloutView = mapView.dequeueReusableCalloutView(withIdentifier: id) as! YMKDefaultCalloutView
        callout = YMKDefaultCalloutView.init(reuseIdentifier: id)
        callout.annotation = annotation
        let rightButton: UIButton = UIButton(type: .detailDisclosure)
        callout.rightView = rightButton
        return callout
    }
}
