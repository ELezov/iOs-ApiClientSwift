//
//  DbHelper.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import RealmSwift


class DbHelper: PlaceDAO, CategoryDAO{
    
    func getPlaces() -> [PlaceRealm] {
        var placesRealm = [PlaceRealm]()
        let storage = RealmStorage<PlaceRealm>()
        placesRealm = Array(storage.getAll())
        return placesRealm
    }
    
    func getPlace(id: Int) -> PlaceRealm {
        var placeRealm = PlaceRealm()
        let storage = RealmStorage<PlaceRealm>()
        placeRealm = storage.getById(id: String(describing: id))!
        return placeRealm
    }
    
    func savePlaces(places: [PlaceRealm]) {
        let storage = RealmStorage<PlaceRealm>()
        storage.saveAll(places)
    }
    
    func savePlace(place: PlaceRealm) {
        let storage = RealmStorage<PlaceRealm>()
        storage.save(place)
    }
    
    // ----------------------
    
    func getCategories() -> [CategoryRealm] {
        var categoriesRealm = [CategoryRealm]()
        let storage = RealmStorage<CategoryRealm>()
        categoriesRealm = Array(storage.getAll())
        return categoriesRealm
    }
    
    func getCategory(id: Int) -> CategoryRealm {
        var categoryRealm = CategoryRealm()
        let storage = RealmStorage<CategoryRealm>()
        categoryRealm = storage.getById(id: String(describing: id))!
        return categoryRealm
    }
    
    func saveCategories(categories: [CategoryRealm]) {
        let storage = RealmStorage<CategoryRealm>()
        storage.saveAll(categories)
    }
    
    func saveCategory(category: CategoryRealm) {
        let storage = RealmStorage<CategoryRealm>()
        storage.save(category)
    }
    // ----------------------
    func getCategoriesList() -> [CategoryListRealm] {
        var categoriesRealm = [CategoryListRealm]()
        let storage = RealmStorage<CategoryListRealm>()
        categoriesRealm = Array(storage.getAll())
        return categoriesRealm
    }
    
    func getCategoryList(id: Int) -> CategoryListRealm {
        var categoryRealm = CategoryListRealm()
        let storage = RealmStorage<CategoryListRealm>()
        categoryRealm = storage.getById(id: String(describing: id))!
        return categoryRealm
    }
    
    func saveCategoriesList(categories: [CategoryListRealm]) {
        let storage = RealmStorage<CategoryListRealm>()
        storage.saveAll(categories)
    }
    
    func saveCategoryList(category: CategoryListRealm) {
        let storage = RealmStorage<CategoryListRealm>()
        storage.save(category)
    }
    
    func  getPlacesByIdsCategory(ids: [Int], _ completion:@escaping ([Place]?, [Category]?) -> Void){
        let converter = Converter()
        let categoriesList = Array(getCategoriesList())
        let categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: categoriesList)
        let placesRealm = Array(getPlaces())
        let placesDB = converter.arrayRealmPlaceToPlace(placesRealm: placesRealm)
        var places = [Place]()
        for item in placesDB{
            for id in ids{
                if (item.categoryId?.contains(id))!{
                    item.categoryId = [id]
                    places.append(item)
                    break
                }
            }
        }
        completion(places, categories)
    }

}
