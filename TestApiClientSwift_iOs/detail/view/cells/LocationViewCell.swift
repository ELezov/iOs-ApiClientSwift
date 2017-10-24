//
//  LocationViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 17.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewCell: UITableViewCell {
    
    
    @IBOutlet weak var AddressLabel: UILabel!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelLocationItem else {
                return
            }
            self.AddressLabel.text = getStringDistance(distance: item.distance) + "  "
            let myLocation = CLLocation(latitude: item.latitude , longitude: item.longitude)
            getPlaceMark(forLocation: myLocation){
                (originPlaceMark, error) in
                if let err = error{
                    print(err)
                } else if let placemark = originPlaceMark{
                    var address = ""
                    
                    if placemark.locality != nil{
                        address += placemark.locality!
                    }
                    
                    if placemark.thoroughfare != nil{
                        address += ", " + placemark.thoroughfare!
                    }
                    
                    if placemark.subThoroughfare != nil{
                        address += " " + placemark.subThoroughfare!
                    }
                    self.AddressLabel.text = self.AddressLabel.text! + address
                }
            }
            
        }
    }
    
    
    func getPlaceMark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placeMarks, error in
            if let err = error{
                completionHandler(nil,err.localizedDescription)
            } else if let placemarkArray = placeMarks{
                if let placemark = placemarkArray.first{
                    completionHandler(placemark, nil)
                } else {
                    completionHandler(nil,"Placemark was nil")
                }
            }else{
                completionHandler(nil,"Unknown error")
            }
        })
        
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
