//
//  realm.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 14.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import RealmSwift

func saveDataByRealm(places: [Place],categories: [Category]){
    let realm = try! Realm()
    saveCategoryByRealm(realm: realm, categories: categories)
    savePlaceByRealm(realm: realm, places: places, categories: categories)
}

func saveCategoryByRealm(realm: Realm, categories: [Category]){
    for category in categories{
        try! realm.write{
            let categoryListRealm = CategoryListRealm()
            categoryListRealm.id = category.id!
            categoryListRealm.name = category.name!
            categoryListRealm.icon = category.icon!
            categoryListRealm.picture = category.picture!
            realm.add(categoryListRealm)
        }
    }
}

func savePlaceByRealm(realm: Realm, places: [Place], categories: [Category])  {
    for place in places{
        do{
            try! realm.write {
                let placeRealm = PlaceRealm()
                placeRealm.id = place.id!
                placeRealm.name = place.name!
                placeRealm.description_1 = place.description!
                placeRealm.rate = place.rate!
                placeRealm.description_2 = place.description_2!
                placeRealm.phone = place.phone!
                placeRealm.cost_text = place.cost_text!
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
                realm.add(placeRealm)
            }
        }
        catch{
            
        }
    }
}

