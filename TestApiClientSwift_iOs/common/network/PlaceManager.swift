import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper

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
        //Если данные в базе данных отсутствуют, то делаем запрос данных из сети.
        if placesRealm.count == 0{
            print("Data From Network")
            NetworkManager().getPlace() { (places, categories, error) -> Void in
                if let placeList = places,
                    let categoryList = categories {
                    saveDataByRealm(places: placeList, categories: categoryList)
                }
                completion(places,categories,error)
            }
        } else {
            var places = [Place]()
            var categories = [Category]()
            print("Data From Realm")
            places = converter.arrayRealmPlaceToPlace(placesRealm: placesRealm)
            categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: categoriesListRealm)
            completion(places,categories,nil)
        }
    }
    
    func getFilterPlaces(ids: [Int], _ completion:@escaping ([Place]?, [Category]?) -> Void){
        let dbHelper = DbHelper()
        dbHelper.getPlacesByIdsCategory(ids: ids){ [weak self] (places, categories) -> Void in
            completion(places, categories)
        }
    }
    
}
