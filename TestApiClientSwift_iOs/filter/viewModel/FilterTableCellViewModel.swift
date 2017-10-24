//
//  FilterTableCellViewModel.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
class FilterTableCellViewModel{
    var categoryImgUrl: String?
    var nameCategory: String?
    
    required init(category: Category){
        // подготавливаем данные для отображения ячейки списка
        self.categoryImgUrl = category.icon
        self.nameCategory = category.name
    }
}




