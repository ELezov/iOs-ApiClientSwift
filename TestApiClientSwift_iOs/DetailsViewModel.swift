//
//  DetailsViewModel.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import UIKit

enum DetailsViewModelItemType{
    case header
    case description
    case timeTable
    case visitingPrice
    case phoneView
    case location
}

protocol DetailsViewModelItem{
    var type: DetailsViewModelItemType { get }
}

class DetailsViewModel: NSObject {
    var items = [DetailsViewModelItem]()
    var placeImgUrl: [String]
    
    init(place: Place, categories: [Category]) {
        let category = categories[(place.category_id?[0])!]
        let headerItem = DetailsViewModelHeaderItem(placeName: place.name!, categoryName: category.name!, categoryImgUrl: category.icon!)
        items.append(headerItem)
        let descriptionItem = DetailsViewModelDescriptionItem(description: place.description!)
        items.append(descriptionItem)
        
        if place.description_2! != ""{
            let timeItem = DetailsViewModelTimeTableItem(timeTable: place.description_2!)
            items.append(timeItem)
        }
        
        if place.cost_text! != ""{
            let visitPrice = DetailsViewModelVisitPriceItem(visitingPrice: place.cost_text!)
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

extension DetailsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
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



