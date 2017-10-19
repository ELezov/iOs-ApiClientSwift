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
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelMapItem else {
                return
            }
            
            let latitude = item.latitude
            let longitude = item.longitude
            
            YMKConfiguration.init().apiKey = "1234567890"
            yandexMapView.showsUserLocation = true
            yandexMapView.canUseCompass = true
            var coordinate = YMKMapCoordinate()
            coordinate.latitude = latitude
            coordinate.longitude = longitude
            //let placeAnnotation = YMKAnnotation.coordinate(coordinate as! YMKAnnotation)
            
            
            yandexMapView.tracksUserLocation = true
            yandexMapView.showTraffic = false
            yandexMapView.canUseCompass = true
            yandexMapView.showsUserLocation = true
            //yandexMapView.userLocationVisible=true
    
            YMKMapPoint.init(x:Int64(latitude), y: Int64(longitude))
            yandexMapView.setCenter(coordinate, atZoomLevel: 15, animated: true)            //self.yandexMapView = self
            
        }
       
        //yandexMapView.mapView}
        //yandexMapView
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
    
}
