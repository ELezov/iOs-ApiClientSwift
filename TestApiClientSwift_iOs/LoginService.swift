//
//  LoginService.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//
import Alamofire

import Foundation

enum LoginService{
    case logIn(name: String, password: String)
}

extension LoginService: Endpoint{
    
    internal var headers: HTTPHeaders {
        return ["" : ""]
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .logIn: return .post
        }
    }
    
    internal var path: String {
        switch self {
        case .logIn:
            return "/login"
        }
    }
    
    var body: Parameters{
        var parameters: Parameters = Parameters()
        switch self {
        case .logIn(let name, let password):
            parameters["username"] = name
            parameters["password"] = password
        }
        
        return parameters
    }
    
    internal var baseURL: String {
        switch self {
        case .logIn:
            return "http://138.68.68.166:9999/api/1"
        }
    }
}
