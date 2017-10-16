//
//  RealmDAO.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

protocol CategoryDAO{
    func getCategories() -> [CategoryRealm]
    func getCategory(id: Int) -> CategoryRealm
    func saveCategory(category: CategoryRealm)
    func saveCategories(categories: [CategoryRealm])
}

protocol PlaceDAO {
    func getPlaces() -> [PlaceRealm]
    func getPlace(id: Int) -> PlaceRealm
    func savePlace(place: PlaceRealm)
    func savePlaces(places: [PlaceRealm])
}


