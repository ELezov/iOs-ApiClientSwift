//
//  PointAnnotation.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 20.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation


class PointAnnotation: NSObject, YMKDraggableAnnotation {
    public func setCoordinate(_ coordinate: YMKMapCoordinate) {
        self.coordinateObj = coordinate
    }

    public func coordinate() -> YMKMapCoordinate {
        return coordinateObj
    }

    var title: NSString! = nil
    var subtitle: NSString! = nil
    var coordinateObj: YMKMapCoordinate! = nil
    
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.coordinateObj = YMKMapCoordinate()
    }
    
    init(title: NSString, subtitile: NSString, coordinate: YMKMapCoordinate) {
        self.title = title
        self.subtitle = subtitile
        self.coordinateObj = coordinate
    }
}
