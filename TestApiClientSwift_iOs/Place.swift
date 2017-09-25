

import Foundation
import ObjectMapper

public class Place: Mappable{
    public var id : Int?
    public var name : String?
    public var category_id : Array<Int>?
    public var description : String?
    public var description_2 : String?
    public var latitude : Double?
    public var longitude : Double?
    public var rate : Int?
    public var cost_sum : String?
    public var cost_text : String?
    public var phone : String?
    public var site : String?
    public var discount_min : Int?
    public var discount_max : Int?
    public var discount_conditions : String?
    public var min_people : String?
    public var max_people : String?
    public var photos : Array<String>?

    required public init?(map:Map){

    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        category_id <- map["category_id"]
        description <- map["description"]
        description_2 <- map["description_2"]
        latitude <- map["latitude"]
        longitude <- map["longtitude"]
        rate <- (map["rate"], TransformOf<Int,String>(fromJSON: { Int($0!)}, toJSON: {$0.map{String($0)}}))
        cost_sum <- map["cost_sum"]
        cost_text <- map["cost_text"]
        phone <- map["phone"]
        site <- map["site"]
        discount_max <- map["discount_max"]
        max_people <- map["max_people"]
        photos <- map["photos"]
    }

    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    
}
