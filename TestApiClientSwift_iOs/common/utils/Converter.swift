//
//  Converter.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import RealmSwift

class Converter {
    
    func placeRealmToPlace(placeRealm: PlaceRealm) -> Place {
        let place = Place()
        place.name = placeRealm.name
        place.id = placeRealm.id
        place.description = placeRealm.description1
        place.rate = placeRealm.rate
        place.timeTable = placeRealm.timeTable
        place.costText = placeRealm.costText
        place.phone = placeRealm.phone
        place.discountMax = placeRealm.discountMax
        place.latitude = placeRealm.latitude
        place.longitude = placeRealm.longitude
        place.isFavorite = placeRealm.isFavorite
        var photos = [String]()
        for photo in placeRealm.photos{
            var photoUrl = ""
            photoUrl = photo.value
            photos.append(photoUrl)
        }
        place.photos = photos
        
        var categoryList = [Int]()
        for category in placeRealm.categories{
            categoryList.append(category.id)
        }
        place.categoryId = categoryList
        return place
    }
    
    func placeToRealmPlace(place: Place, categories: [Category]) -> PlaceRealm {
        let placeRealm = PlaceRealm()
        if let id = place.id {
            placeRealm.id = id
        }
        if let name = place.name {
            placeRealm.name = name
        }
        if let description = place.description {
            placeRealm.description1 = description
        }
        if let rate = place.rate {
            placeRealm.rate = rate
        }
        if let timeTable = place.timeTable {
            placeRealm.timeTable = timeTable
        }
        if let phone = place.phone {
            placeRealm.phone = phone
        }
        if let costText = place.costText {
            placeRealm.costText = costText
        }
        if let discountMax = place.discountMax {
            placeRealm.discountMax = discountMax
        }
        if let latitude = place.latitude,
            let longitude = place.longitude {
            placeRealm.latitude = latitude
            placeRealm.longitude = longitude
        }
        placeRealm.isFavorite = place.isFavorite
        
        let categoryListRealm = List<CategoryRealm>()
        if let categoryId = place.categoryId {
            for item in categoryId {
                if let i = categories.index( where: {$0.id == item}){
                    let category = categories[i]
                    let categoryReal = CategoryRealm()
                    if let name = category.name {
                        categoryReal.name = name
                    }
                    if let id = category.id {
                        categoryReal.id = id
                    }
                    if let icon = category.icon {
                        categoryReal.icon = icon
                    }
                    if let picture = category.picture {
                        categoryReal.picture = picture
                    }
                    categoryListRealm.append(categoryReal)
                }
            }
        }
        let photosRealm = List<StringObject>()
        if let photos = place.photos {
            for photo in photos{
                let stringObject = StringObject()
                stringObject.value = photo
                photosRealm.append(stringObject)
            }
        }
        placeRealm.photos = photosRealm
        placeRealm.categories = categoryListRealm
        return placeRealm
    }
    
    func arrayCategoryToRealmListCategory(categories: [Category]) -> [CategoryListRealm]{
        var categoriesListRealm = [CategoryListRealm]()
        for category in categories{
            let categoryListRealm = CategoryListRealm()
            if let name = category.name {
                categoryListRealm.name = name
            }
            if let id = category.id {
                categoryListRealm.id = id
            }
            if let icon = category.icon {
                categoryListRealm.icon = icon
            }
            if let picture = category.picture {
                categoryListRealm.picture = picture
            }

            categoriesListRealm.append(categoryListRealm)
        }
        return categoriesListRealm
    }
    
    func arrayCategoryToRealmCategory(categories: [Category]) -> [CategoryRealm]{
        var categoriesRealm = [CategoryRealm]()
        for category in categories{
            let categoryRealm = CategoryRealm()
            if let name = category.name {
                categoryRealm.name = name
            }
            if let id = category.id {
                categoryRealm.id = id
            }
            if let icon = category.icon {
                categoryRealm.icon = icon
            }
            if let picture = category.picture {
                categoryRealm.picture = picture
            }
            categoriesRealm.append(categoryRealm)
        }
        return categoriesRealm
    }
    
    func arrayCategoryRealmToRealmListCategory(categories: [CategoryRealm]) -> [CategoryListRealm]{
        var categoriesRealm = [CategoryListRealm]()
        for category in categories{
            let categoryRealm = CategoryListRealm()
            categoryRealm.id = category.id
            categoryRealm.name = category.name
            categoryRealm.icon = category.icon
            categoryRealm.picture = category.picture
            categoriesRealm.append(categoryRealm)
        }
        return categoriesRealm
    }
    
    func arrayCategoryListRealmToRealmCategory(categories: [CategoryListRealm]) -> [CategoryRealm]{
        var categoriesRealm = [CategoryRealm]()
        for category in categories{
            let categoryRealm = CategoryRealm()
            categoryRealm.id = category.id
            categoryRealm.name = category.name
            categoryRealm.icon = category.icon
            categoryRealm.picture = category.picture
            categoriesRealm.append(categoryRealm)
        }
        return categoriesRealm
    }


    
    func arrayPlaceToRealmPlace(places: [Place], categories: [Category]) -> [PlaceRealm] {
        var placesRealm = [PlaceRealm]()
        for place in places{
            let placeRealm = placeToRealmPlace(place: place, categories: categories)
            placesRealm.append(placeRealm)
        }
        return placesRealm
    }
    
    func arrayRealmPlaceToPlace(placesRealm: [PlaceRealm]) -> [Place] {
        var places = [Place]()
        for item in placesRealm {
            let place = placeRealmToPlace(placeRealm: item)
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
    
    func convertStringToUrlArray(urls: [String]) -> [URL] {
        var urlArrays = [URL]()
        for item in urls{
            let url = URL(string: BASE_URL_API + item)
            urlArrays.append(url!)
        }
        return urlArrays
    }
    

}
