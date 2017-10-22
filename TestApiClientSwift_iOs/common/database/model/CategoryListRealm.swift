import Foundation
import RealmSwift

class CategoryListRealm: Object, PrimaryKeyAware {
    dynamic var id : Int = 0
    dynamic var name : String = ""
    dynamic var icon : String = ""
    dynamic var picture : String = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }

}
