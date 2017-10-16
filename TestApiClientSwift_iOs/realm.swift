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
    saveCategoryByRealm(categories: categories)
    savePlaceByRealm(places: places, categories: categories)
}

func saveCategoryByRealm(categories: [Category]){
    let converter = Converter()
    let dbHelper = DbHelper()
    let categoriesListRealm = converter.arrayCategoryToRealmListCategory(categories: categories)

    dbHelper.saveCategoriesList(categories: categoriesListRealm)
}

func savePlaceByRealm(places: [Place], categories: [Category])  {
    let converter = Converter()
    let dbHelper = DbHelper()
    let placesRealm = converter.arrayPlaceToRealmPlace(places: places, categories: categories)
    dbHelper.savePlaces(places: placesRealm)
}


