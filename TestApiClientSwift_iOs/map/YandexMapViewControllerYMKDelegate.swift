//
//  YandexMapViewControllerYMKDelegate.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension YandexMapViewController: YMKMapViewDelegate {
    
    func mapView(_ mapView: YMKMapView!, viewFor annotation: YMKAnnotation!) -> YMKAnnotationView! {
        let id = "pointAnnotation"
        var point: YMKPinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as! YMKPinAnnotationView
        if (point == nil){
            point = YMKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            point.canShowCallout = true
        }
        
        return point
    }
    
    func mapView(_ mapView: YMKMapView!, calloutViewFor annotation: YMKAnnotation!) -> YMKCalloutView! {
        let id = "pointCallout"
        var callout: YMKDefaultCalloutView = mapView.dequeueReusableCalloutView(withIdentifier: id) as! YMKDefaultCalloutView
        if (callout == nil){
            callout = YMKDefaultCalloutView.init(reuseIdentifier: id)
        }
        callout.annotation = annotation
        //let rightButton: UIButton = UIButton(type: .detailDisclosure)
        //callout.rightView = rightButton
        return callout
    }
}
