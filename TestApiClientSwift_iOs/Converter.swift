//
//  Converter.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import RealmSwift

class Converter{
    
    func arrayCategoryToRealmListCategory(categories: [Category]) -> [CategoryListRealm]{
        var categoriesListRealm = [CategoryListRealm]()
        for category in categories{
            let categoryListRealm = CategoryListRealm()
            categoryListRealm.id = category.id!
            categoryListRealm.name = category.name!
            categoryListRealm.icon = category.icon!
            categoryListRealm.picture = category.picture!
            categoriesListRealm.append(categoryListRealm)
        }
        return categoriesListRealm
    }
    
    func arrayCategoryToRealmCategory(categories: [Category]) -> [CategoryRealm]{
        var categoriesRealm = [CategoryRealm]()
        for category in categories{
            let categoryRealm = CategoryRealm()
            categoryRealm.id = category.id!
            categoryRealm.name = category.name!
            categoryRealm.icon = category.icon!
            categoryRealm.picture = category.picture!
            categoriesRealm.append(categoryRealm)
        }
        return categoriesRealm
    }
    
    func arrayPlaceToRealmPlace(places: [Place], categories: [Category]) -> [PlaceRealm] {
        var placesRealm = [PlaceRealm]()
        for place in places{
            let placeRealm = PlaceRealm()
            placeRealm.id = place.id!
            placeRealm.name = place.name!
            placeRealm.description_1 = place.description!
            placeRealm.rate = place.rate!
            placeRealm.description_2 = place.description_2!
            placeRealm.phone = place.phone!
            placeRealm.cost_text = place.cost_text!
            placeRealm.discount_max = place.discount_max!
            let categoryListRealm = List<CategoryRealm>()
            for item in place.category_id!{
                if let i = categories.index( where: {$0.id == item}){
                    let category = categories[i]
                    let categoryReal = CategoryRealm()
                    categoryReal.name = category.name!
                    categoryReal.id = category.id!
                    categoryReal.icon = category.icon!
                    categoryReal.picture = category.picture!
                    categoryListRealm.append(categoryReal)
                }
            }
            let photosRealm = List<StringObject>()
            for photo in place.photos!{
                let stringObject = StringObject()
                stringObject.value = photo
                photosRealm.append(stringObject)
            }
            placeRealm.photos = photosRealm
            placeRealm.categories = categoryListRealm
            placesRealm.append(placeRealm)
        }
        return placesRealm
    }
    
    func arrayRealmPlaceToPlace(placesRealm: [PlaceRealm]) -> [Place] {
        var places = [Place]()
        for item in placesRealm{
            let place = Place()
            place.name = item.name
            place.id = item.id
            place.description = item.description_1
            place.rate = item.rate
            place.description_2 = item.description_2
            place.cost_text = item.cost_text
            place.phone = item.phone
            place.discount_max = item.discount_max
            var photos = [String]()
            for photo in item.photos{
                var photoUrl = ""
                photoUrl = photo.value
                photos.append(photoUrl)
            }
            place.photos = photos
            
            var categoryList = [Int]()
            for category in item.categories{
                categoryList.append(category.id)
            }
            place.category_id = categoryList
            places.append(place)
        }
        return places
    }
    
    func arrayRealmListCategoryToCategory(categoriesListRealm: [CategoryListRealm]) -> [Category] {
        var categories = [Category]()
        for item in categoriesListRealm{
            let category = Category()
            category.name = item.name
            category.id = item.id
            category.icon = item.icon
            category.picture = item.picture
            categories.append(category)
        }
        return categories
    }
    
    

}
