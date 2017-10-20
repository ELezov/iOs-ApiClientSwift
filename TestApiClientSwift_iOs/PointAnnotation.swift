//
//  PointAnnotation.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 20.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

class PointAnnotation: NSObject, YMKDraggableAnnotation {
    public func coordinate() -> YMKMapCoordinate {
        return coordinateObject
    }
    
    private var title = ""
    private var subtitle = ""
    private var coordinateObject = YMKMapCoordinate()
    
    public func setCoordinate(_ coordinate: YMKMapCoordinate) {
        self.coordinateObject = coordinate
    }
    
    public func setTitile(_ title:String){
        self.title = title
    }
    
    public func setSubTitle(_ subTitle: String){
        self.subtitle = subTitle
    }
    
    required override init() {
        
    }
}
