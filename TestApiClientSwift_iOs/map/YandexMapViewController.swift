//
//  YandexMapViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 19.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class YandexMapViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    var placeAnnotation = PointAnnotation()
    //Segue
    static let idSegueShow = "showMapCustom"
    static let idSegueShowUnwind = "showMapCustomUnwind"
    
    @IBOutlet weak var yandexMapView: YMKMapView!
    var latitude = 54.709400
    var longitude = 20.427640
    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: YandexMapViewController.idSegueShowUnwind , sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMapView()
        self.configureAndInstallAnnotations()
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
        self.placeAnnotation.setTitile("")
        self.placeAnnotation.setSubTitle("")
        self.yandexMapView.addAnnotation(self.placeAnnotation)
        //self.yandexMapView.selectedAnnotation = self.placeAnnotation
    }

}
