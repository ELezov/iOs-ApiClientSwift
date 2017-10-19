import UIKit
//import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        YMKConfiguration.sharedInstance().apiKey = "1234567890"
        
        //Realm Migration
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        return true
    }
    

}

