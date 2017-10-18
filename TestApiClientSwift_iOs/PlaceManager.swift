import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper
import Toast_Swift

class PlaceManager{
    func getPlaces(_ completion:@escaping ([Place]?, [Category]?, String?) -> Void) {
        print("RealmDb", Realm.Configuration.defaultConfiguration.description)
        getData(completion)
    }

    func getData(_ completion:@escaping ([Place]?, [Category]?, String?) -> Void){
        
        let dbHelper = DbHelper()
        let converter = Converter()
        let placesRealm = dbHelper.getPlaces()
        let categoriesListRealm = dbHelper.getCategoriesList()
        if placesRealm.count == 0{
            print("Data From Network")
            NetworkManager().getPlace(completion)
        } else {
            var places = [Place]()
            var categories = [Category]()
            print("Data From Realm")
            places = converter.arrayRealmPlaceToPlace(placesRealm: placesRealm)
            categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: categoriesListRealm)
            completion(places,categories,nil)
        }
        
    }
    
    func  getDataByFilter(ids: [Int], _ completion:@escaping ([Place]?, [Category]?) -> Void){
        let converter = Converter()
        let realm = try! Realm()
        let categoriesList = Array(realm.objects(CategoryListRealm.self))
        let categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: categoriesList)
        let placesRealm = Array(realm.objects(PlaceRealm.self))
        let placesDB = converter.arrayRealmPlaceToPlace(placesRealm: placesRealm)
        var places = [Place]()
        for item in placesDB{
            for id in ids{
                if (item.category_id?.contains(id))!{
                    item.category_id = [id]
                    places.append(item)
                    break
                }
            }
        }
        completion(places, categories)
    }
        
}
