//
//  LoginToken.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 27.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import ObjectMapper

public class LoginToken: Mappable {
    public var token : String?
    
    required public init?(map: Map){
        
    }
    
    init() {
        
    }
    
    public func mapping(map: Map) {
        token <- map["token"]
    }
    
}
