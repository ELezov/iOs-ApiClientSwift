import Foundation
import RealmSwift
import Realm

class PlaceRealm: Object, PrimaryKeyAware{
    dynamic var id : Int = 0
    dynamic var name : String = ""
    var categories = List<CategoryRealm>()
    dynamic var description_1 : String = ""
    dynamic var description_2 : String = ""
    dynamic var latitude : Double = 0.0
    dynamic var longitude : Double = 0.0
    dynamic var rate : Int = 0
    dynamic var cost_text : String = ""
    dynamic var phone : String = ""
    dynamic var site : String = ""
    dynamic var discount_max : Int = 0
    var photos = List<StringObject>()

    override static func primaryKey() -> String?{
        return "id"
    }
}

class StringObject: Object{
    dynamic var value = ""
}
