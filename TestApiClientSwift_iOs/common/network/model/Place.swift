

import Foundation
import ObjectMapper

public class Place: Mappable{
    public var id : Int?
    public var name : String?
    public var categoryId : Array<Int>?
    public var description : String?
    public var timeTable : String?
    public var latitude : Double?
    public var longitude : Double?
    public var rate : Int?
    public var costSum : String?
    public var costText : String?
    public var phone : String?
    public var site : String?
    public var discountMin : Int?
    public var discountMax : Int?
    public var discountConditions : String?
    public var minPeople : String?
    public var maxPeople : String?
    public var photos : Array<String>?
    
    var distance: Int = 0

    required public init?(map:Map){

    }

    init() {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        categoryId <- map["category_id"]
        description <- map["description"]
        timeTable <- map["description_2"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        rate <- (map["rate"], TransformOf<Int,String>(fromJSON: { Int($0!)}, toJSON: {$0.map{String($0)}}))
        costSum <- map["cost_sum"]
        costText <- map["cost_text"]
        phone <- map["phone"]
        site <- map["site"]
        discountMax <- (map["discount_max"], TransformOf<Int,String>(fromJSON: { Int($0!)}, toJSON: {$0.map{String($0)}}))
        maxPeople <- map["max_people"]
        photos <- map["photos"]
    }

    init(name: String, description: String, description2: String, categoryId: [Int], rate: Int, costText: String, phone: String) {
        self.name = name
        self.description = description
        self.timeTable = description2
        self.categoryId = categoryId
        self.rate = rate
        self.costText = costText
        self.phone = phone
    }

    
}
