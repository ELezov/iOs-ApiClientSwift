//
//  DetailsViewModel.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

public enum DetailsViewModelItemType{
    case placePhoto
    case header
    case description
    case timeTable
    case visitingPrice
    case phoneView
    case location
    case map
}

public protocol DetailsViewModelItem{
    var type: DetailsViewModelItemType { get }
}

class DetailsViewModel: NSObject {
    var items = [DetailsViewModelItem]()
    var placeImgUrl: [String]
    var place: Place
    var phoneCell = PhotoDetailViewCell()
    
    init(place: Place, categories: [Category]) {
        
        //Подготавливаем данные для отображения в TableView
        
        let category : Category
        let index = categories.index(where: {$0.id == place.categoryId?.first})
        category = categories[index!]
        self.place = place
        self.placeImgUrl = place.photos!
        
        let placePhotoItem = DetailsViewModelPlacePhotoItem(photo: (place.photos?.first)!)
        items.append(placePhotoItem)
        
        let headerItem = DetailsViewModelHeaderItem(placeName: place.name!,
                                    categoryName: category.name!,
                                    categoryImgUrl: category.icon!)
        items.append(headerItem)
        
        let descriptionItem = DetailsViewModelDescriptionItem(description: place.description!)
        items.append(descriptionItem)
        
        if place.timeTable! != ""{
            let timeItem = DetailsViewModelTimeTableItem(timeTable: place.timeTable!)
            items.append(timeItem)
        }
        
        if place.costText! != ""{
            let visitPrice = DetailsViewModelVisitPriceItem(visitingPrice: place.costText!)
            items.append(visitPrice)
        }
        
        if place.phone! != "" {
            let phoneItem = DetailsViewModelPhoneItem(phoneText: place.phone!)
            items.append(phoneItem)
        }
        
        let locationItem = DetailsViewModelLocationItem(latitude: place.latitude!,
                                        longitude: place.longitude!,
                                        distance: place.distance)
        items.append(locationItem)
        
        let mapItem = DetailsViewModelMapItem(latitude: place.latitude!, longitude: place.longitude!)
        items.append(mapItem)
    }
}

//ViewModels для ячеек

class DetailsViewModelPlacePhotoItem: DetailsViewModelItem {
    var type: DetailsViewModelItemType{
        return .placePhoto
    }
    
    var photoUrl: String
    
    init(photo: String){
        self.photoUrl = BASE_URL_API + photo
    }
}

class DetailsViewModelHeaderItem: DetailsViewModelItem{
    var type: DetailsViewModelItemType{
        return .header
    }
    
    var categoryImgUrl: String
    var categoryName: String
    var placeName: String
    
    init(placeName: String, categoryName:String,categoryImgUrl:String){
        self.placeName = placeName
        self.categoryName = categoryName
        self.categoryImgUrl = categoryImgUrl
    }
}

class DetailsViewModelDescriptionItem: DetailsViewModelItem{
    var type: DetailsViewModelItemType{
        return .description
    }
    
    var descriptionText: String
    
    init(description: String) {
        self.descriptionText = description
    }
}

class DetailsViewModelTimeTableItem: DetailsViewModelItem{
    var  type: DetailsViewModelItemType{
        return .timeTable
    }
    
    var timeTable: String
    
    init(timeTable: String) {
        self.timeTable = timeTable
    }
}

class DetailsViewModelVisitPriceItem: DetailsViewModelItem{
    var type: DetailsViewModelItemType{
        return .visitingPrice
    }
    
    var visitingPriceText: String
    
    init(visitingPrice: String) {
        self.visitingPriceText = visitingPrice
    }
}

class DetailsViewModelPhoneItem: DetailsViewModelItem{
    var type: DetailsViewModelItemType{
        return .phoneView
    }
    
    var phoneText: String
    
    init(phoneText: String) {
        self.phoneText = phoneText
    }
}

class DetailsViewModelLocationItem: DetailsViewModelItem{
    var type: DetailsViewModelItemType{
        return .location
    }
    var distance: Int
    var latitude: Double
    var longitude: Double
    var addressPlace: String
    
    init(latitude: Double,longitude: Double, distance: Int) {
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        self.addressPlace = ""
        let myLocation = CLLocation(latitude: latitude, longitude: longitude)
        getPlaceMark(forLocation: myLocation) { (originPlaceMark, error) in
            if let err = error {
                print(err)
            } else if let placemark = originPlaceMark {
                var address = ""
                if placemark.locality != nil {
                    address += placemark.locality!
                }
                if placemark.thoroughfare != nil {
                    address += ", " + placemark.thoroughfare!
                }
                if placemark.subThoroughfare != nil {
                    address += " " + placemark.subThoroughfare!
                }
                self.addressPlace = address
            }
        }
    }
    
    func getPlaceMark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> () ) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placeMarks, error) in
            if let err = error {
                completionHandler(nil, err.localizedDescription)
            } else if let placemarkArray = placeMarks {
                if let placemark = placemarkArray.first {
                    completionHandler(placemark, nil)
                } else {
                    completionHandler(nil, "Placemark was nil")
                }
            } else {
                completionHandler(nil, "Unknown error")
            }
        })
    }
}

class DetailsViewModelMapItem: DetailsViewModelItem{
    var type: DetailsViewModelItemType{
        return .map
    }
    
    var latitude: Double
    var longitude: Double
   // var phoneText: String
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}



