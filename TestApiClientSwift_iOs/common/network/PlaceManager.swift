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
                var placesResult = [Place]()
                if let placeList = places,
                    let categoryList = categories {
                    saveDataByRealm(places: placeList, categories: categoryList)
                    placesResult = converter.arrayRealmPlaceToPlace(placesRealm: dbHelper.getPlaces())
                }
                completion(placesResult,categories,error)
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
    
    func getPlacesFromDb(_ completion:@escaping ([Place]?, [Category]?) -> Void){
        let dbHelper = DbHelper()
        let converter = Converter()
        let placesRealm = dbHelper.getPlaces()
        let categoriesRealm = dbHelper.getCategoriesList()
        let places = converter.arrayRealmPlaceToPlace(placesRealm: placesRealm)
        let categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: categoriesRealm)
        completion(places, categories)
    }
    
    func getFilterPlaces(ids: [Int], _ completion:@escaping ([Place]?, [Category]?) -> Void){
        let dbHelper = DbHelper()
        dbHelper.getPlacesByIdsCategory(ids: ids){(places, categories) -> Void in
            completion(places, categories)
        }
    }
    
    func savePlace(place: Place, categories: [Category]){
        let dbHelper = DbHelper()
        let converter = Converter()
        let placeRealm = converter.placeToRealmPlace(place: place, categories: categories)
        dbHelper.savePlace(place: placeRealm)
    }
    
    func getPlaceFromDb(id: Int) -> Place {
        let dbHelper = DbHelper()
        let converter = Converter()
        let placeRealm = dbHelper.getPlace(id: id)
        let place = converter.placeRealmToPlace(placeRealm: placeRealm)
        return place
    }
    
    func getPullRefresh( _ completion:@escaping ([Place]?, [Category]?, String?) -> Void) {
        let dbHelper = DbHelper()
        let converter = Converter()
        var places = [Place]()
        var categories = [Category]()
        NetworkManager().getPlace() { (placeList, categoryList, error) -> Void in
            if error == nil {
                dbHelper.deleteAllStringObjects()
                self.updateOrSaveData(dbHelper: dbHelper, converter: converter, places: placeList!, categories: categoryList!)
                places = converter.arrayRealmPlaceToPlace(placesRealm: dbHelper.getPlaces())
                categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: dbHelper.getCategoriesList())
                completion(places,categories,nil)
            } else {
                places = converter.arrayRealmPlaceToPlace(placesRealm: dbHelper.getPlaces())
                categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: dbHelper.getCategoriesList())
                if !places.isEmpty {
                    print("Refresh DB")
                    completion(places,categories,nil)
                } else {
                    print("Refresh nil")
                    completion(nil,nil,error?.description)
                }
            }
        }
    }
    
    func  updateOrSaveData(dbHelper: DbHelper, converter: Converter, places: [Place], categories: [Category]) {
        let categoriesListRealm = converter.arrayCategoryToRealmListCategory(categories: categories)
        dbHelper.saveCategoriesList(categories: categoriesListRealm)
        let placesRealm = converter.arrayPlaceToRealmPlace(places: places, categories: categories)
        for placeRealm in placesRealm {
            dbHelper.updateOrSave(id: placeRealm.id, place: placeRealm)
        }
    }

    
}
