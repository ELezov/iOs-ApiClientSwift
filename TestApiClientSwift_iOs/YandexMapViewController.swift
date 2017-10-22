//
//  YandexMapViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 19.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class YandexMapViewController: UIViewController, YMKMapViewDelegate {
    @IBOutlet weak var closeButton: UIButton!
    
    var placeAnnotation = PointAnnotation()
    //Segue
    static let idSegueShow = "showMapCustom"
    static let idSegueShowUnwind = "showMapCustomUnwind"
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: YandexMapViewController.idSegueShowUnwind , sender: self)
    }
    
//    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
//        
//    }
    
    
    @IBOutlet weak var yandexMapView: YMKMapView!
    
    var latitude = 54.709400
    var longitude = 20.427640
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMapView()
        self.configureAndInstallAnnotations()
    }
    

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    
    func configureMapView(){
        self.yandexMapView.showsUserLocation = false
        self.yandexMapView.showTraffic = false
        self.yandexMapView.setCenter(YMKMapCoordinateMake(latitude, longitude), atZoomLevel: 15, animated: false)
    }
    
    func configureAndInstallAnnotations(){
        let coordinate = YMKMapCoordinateMake(latitude, longitude)
        self.placeAnnotation = PointAnnotation()
        self.placeAnnotation.setCoordinate(coordinate)
        self.placeAnnotation.setTitile("Metro")
        self.placeAnnotation.setSubTitle("станция Повелецкая")
        self.yandexMapView.addAnnotation(self.placeAnnotation)
        //self.yandexMapView.selectedAnnotation = self.placeAnnotation
    }

}
