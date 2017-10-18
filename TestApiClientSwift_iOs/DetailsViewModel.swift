//
//  DetailsViewModel.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import Agrume
import UIKit

public enum DetailsViewModelItemType{
    case placePhoto
    case header
    case description
    case timeTable
    case visitingPrice
    case phoneView
    case location
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
        let category = categories[(place.categoryId?[0])!]
        self.place = place
        self.placeImgUrl = place.photos!
        
        let placePhotoItem = DetailsViewModelPlacePhotoItem(photo: (place.photos?.first)!)
        items.append(placePhotoItem)
        
        let headerItem = DetailsViewModelHeaderItem(placeName: place.name!, categoryName: category.name!, categoryImgUrl: category.icon!)
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
        
        let locationItem = DetailsViewModelLocationItem()
        items.append(locationItem)
        
        print("DetailsViewModel", items.count)
        self.placeImgUrl = place.photos!
    }
}

extension DetailsViewModel: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .placePhoto:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDetailViewCell.identifier, for: indexPath) as? PhotoDetailViewCell{
                self.phoneCell = cell
                cell.item = item
                
                return cell
            }

        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderPlaceViewCell.identifier, for: indexPath) as? HeaderPlaceViewCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCell.identifier, for: indexPath) as? DescriptionViewCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .timeTable:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .visitingPrice:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VisitingPriceCell.identifier, for: indexPath) as? VisitingPriceCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .phoneView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhoneViewCell.identifier, for: indexPath) as? PhoneViewCell{
                cell.item = item
                let tap = UITapGestureRecognizer(target: self, action: #selector(DetailsViewModel.makeCallPhone))
                cell.addGestureRecognizer(tap)
                cell.isUserInteractionEnabled = true
                return cell
            }
        case .location:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LocationViewCell.identifier, for: indexPath) as? LocationViewCell{
                cell.item = item
                return cell
            }
        
        }
        return UITableViewCell()
    }
    
    func makeCallPhone(){
        if let url = URL(string: "tel://\(self.place.phone)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else {
                UIApplication.shared.openURL(url)
            }
            print("1",url.description)
        }
        print(self.place.phone)
    }
    
//    func openGalleryAction(){
//        print("Haha", "oOops")
//        let urls = placeImgUrl
//        let converter = Converter()
//        let agrume = Agrume(imageUrls: converter.convertStringToUrlArray(urls: urls))
//        agrume.showFrom(PlaceDetailsViewController)
//    }
    
    
    
}

class DetailsViewModelPlacePhotoItem: DetailsViewModelItem{
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
    
    init() {
        
    }
}



