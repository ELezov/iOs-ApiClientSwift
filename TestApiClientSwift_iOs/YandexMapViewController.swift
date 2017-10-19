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
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBOutlet weak var yandexMapView: YMKMapView!
    
    var latitude = 54.709400
    var longitude = 20.427640
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var coordinate = YMKMapCoordinate()
        coordinate.latitude = latitude
        coordinate.longitude = longitude
        yandexMapView.showTraffic = false
        yandexMapView.setCenter(coordinate, atZoomLevel: 15, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Hiden")
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Show")
        navigationController?.navigationBar.isHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureMapView(){
        self.yandexMapView.showsUserLocation = false
        self.yandexMapView.showTraffic = false
        self.yandexMapView.setCenter(YMKMapCoordinateMake(latitude, longitude), atZoomLevel: 13, animated: false)
    }
    
    func configureAndInstallAnnotations(){
        let coordinate = YMKMapCoordinateMake(latitude, longitude)
    }

}
