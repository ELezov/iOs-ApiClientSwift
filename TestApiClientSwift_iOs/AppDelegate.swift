import UIKit
//import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        YMKConfiguration.sharedInstance().apiKey = "1234567890"
        
        //Realm Migration
//        let config = Realm.Configuration(
//            schemaVersion: 1,
//            migrationBlock: { migration, oldSchemaVersion in
//                if  oldSchemaVersion < 1 {
//                    migration.enumerate(PlaceRealm.className()) { oldObject, newObject in
//                        newObject["isFavorite"] = setCount
//                }
//        }
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        return true
    }
}
    



