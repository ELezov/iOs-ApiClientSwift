//
//  BaseTableViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 22.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var baseTableViewModel: Any?
    
    static let id = "BaseTableViewCell"

    func setData(item: DetailsViewModelItem){
        let type = item.type
        let a = "aga"
        switch  type {
        case .placePhoto:
            print(a)
        case .header:
            print(a)
        case .description:
            self.baseTableViewModel = item as! DetailsViewModelDescriptionItem
        case .timeTable:
            print(a)
        case .visitingPrice:
            print(a)
        case .phoneView:
            print(a)
        case .location:
            print(a)
        case .map:
            print(a)
        }
    }
}
