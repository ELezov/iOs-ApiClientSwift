//
//  PrimaryKeyAware.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//
import Foundation

protocol PrimaryKeyAware {
    var id: Int { get }
    static func primaryKey() -> String?
}
