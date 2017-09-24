

import Foundation
import ObjectMapper

public class Category: Mappable {
    public var id : Int?
    public var name : String?
    public var icon : String?
    public var picture : String?

    required public init?(map: Map){
        
    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        picture <- map["picture"]
    }

}
