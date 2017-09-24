

import Foundation
import ObjectMapper

public class ApiBaseResult: Mappable {
    public var places : Array<Place>?
    public var categories : Array<Category>?

    required public init?(map: Map) {

    }

    public func mapping(map: Map) {
        places <- map["points"]
        categories <- map["categories"]
    }


}
