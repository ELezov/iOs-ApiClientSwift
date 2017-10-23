//
//  FilterViewModel.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
class FilterViewModel{
    fileprivate var cellsArray = [FilterTableCellViewModel]()
    var categories : [Category]!

    init(categories: [Category]){
        self.categories = categories
        for category in self.categories{
            self.cellsArray.append(FilterTableCellViewModel(category: category))
        }
    }
    
    func numberOfPlaces() -> Int{
        return cellsArray.count
    }
    
    func cellViewModel(_ index: Int) -> FilterTableCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }

}







