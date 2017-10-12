

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

    init() {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        category_id <- map["category_id"]
        description <- map["description"]
        description_2 <- map["description_2"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        rate <- (map["rate"], TransformOf<Int,String>(fromJSON: { Int($0!)}, toJSON: {$0.map{String($0)}}))
        cost_sum <- map["cost_sum"]
        cost_text <- map["cost_text"]
        phone <- map["phone"]
        site <- map["site"]
        discount_max <- (map["discount_max"], TransformOf<Int,String>(fromJSON: { Int($0!)}, toJSON: {$0.map{String($0)}}))
        max_people <- map["max_people"]
        photos <- map["photos"]
    }

    init(name: String, description: String, description2: String, categoryId: [Int], rate: Int, costText: String, phone: String) {
        self.name = name
        self.description = description
        self.description_2 = description2
        self.category_id = categoryId
        self.rate = rate
        self.cost_text = costText
        self.phone = phone
    }

    
}
