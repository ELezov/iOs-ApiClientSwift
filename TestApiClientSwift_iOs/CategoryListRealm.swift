//
//  CategoryListRealm.swift
//  TestApiClientSwift_iOs
//
//  Created by KODE_H6 on 26.09.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import RealmSwift

public class CategoryListRealm: Object {
    dynamic var id : Int = 0
    dynamic var name : String = ""
    dynamic var icon : String = ""
    dynamic var picture : String = ""
}
