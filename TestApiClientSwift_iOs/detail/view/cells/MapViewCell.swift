//
//  MapViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 18.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class MapViewCell: UITableViewCell, YMKMapViewDelegate {

    
    @IBOutlet weak var yandexMapView: YMKMapView!
    
    var latitude: Double?
    var longitude : Double?
    var placeAnnotation : PointAnnotation?
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelMapItem else {
                return
            }
            
            self.latitude = item.latitude
            self.longitude = item.longitude

            self.configureMapView()
            self.configureAndInstallAnnotations()
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMapView() {
        self.yandexMapView.showsUserLocation = false
        self.yandexMapView.showTraffic = false
        self.yandexMapView.setCenter(YMKMapCoordinateMake(latitude!, longitude!), atZoomLevel: 15, animated: false)
    }
    
    func configureAndInstallAnnotations(){
        self.yandexMapView.removeAnnotations(self.yandexMapView.annotations)
        let coordinate = YMKMapCoordinateMake(latitude!, longitude!)
        self.placeAnnotation = PointAnnotation()
        self.placeAnnotation?.setCoordinate(coordinate)
        //self.placeAnnotation = PointAnnotation(title: "Haha", subtitile: "Hoho", coordinate: coordinate)
        self.yandexMapView.addAnnotation(self.placeAnnotation)
    }
    
    func mapView(_ mapView: YMKMapView!, viewFor annotation: YMKAnnotation!) -> YMKAnnotationView! {
        let id = "pointAnnotation"
        var point: YMKPinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as! YMKPinAnnotationView
        point = YMKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
        point.canShowCallout = true
        return point
    }
    
    func mapView(_ mapView: YMKMapView!, calloutViewFor annotation: YMKAnnotation!) -> YMKCalloutView! {
        let id = "pointCallout"
        var callout: YMKDefaultCalloutView = mapView.dequeueReusableCalloutView(withIdentifier: id) as! YMKDefaultCalloutView
        callout = YMKDefaultCalloutView.init(reuseIdentifier: id)
        callout.annotation = annotation
        return callout
    }
    
}
