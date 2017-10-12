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
        let real = try! Realm()
        let placesRealm = real.objects(PlaceRealm.self)
        let categoriesListReal = real.objects(CategoryListRealm.self)
        print("Size Realm Place One",String(describing: placesRealm.count))
        if placesRealm.count == 0 {
            print("Data From Network")
            loadDataFromNetwork(completion)
        } else{
            var places = [Place]()
            var categories = [Category]()
            print("Data From Realm")
            for item in placesRealm{
                let place = Place()
                place.name = item.name
                place.id = item.id
                place.description = item.description_1
                place.rate = item.rate
                place.description_2 = item.description_2
                place.cost_text = item.cost_text
                place.phone = item.phone
                var photos = [String]()
                for photo in item.photos{
                    var photoUrl = ""
                    photoUrl = photo.value
                    photos.append(photoUrl)
                }
                place.photos = photos

                var categoryList = [Int]()
                for category in item.categories{
                    categoryList.append(category.id)
                }
                place.category_id = categoryList
                places.append(place)
            }
            for item in categoriesListReal{
                let category = Category()
                category.name = item.name
                category.id = item.id
                category.icon = item.icon
                category.picture = item.picture
                categories.append(category)
            }
            completion(places,categories,nil)
        }

    }

    func loadDataFromNetwork(_ completion:@escaping ([Place]?, [Category]?, String?) -> Void){

        let header : HTTPHeaders = ["Authorization" : "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"]
        // Do any additional setup after loading the view, typically from a nib.


        Alamofire.request("http://138.68.68.166:9999/api/1/content",headers: header).validate().responseObject{
            (response: DataResponse<ApiBaseResult>) in
            switch response.result{
            case .success(let value):
                let resultObject = response.result.value
                let resultPlaces = resultObject?.places
                let resultCategories = resultObject?.categories
                print("Size places", resultPlaces?.count ?? 0)
                self.saveDataByRealm(places: resultPlaces!, categories: resultCategories!)
                completion(resultPlaces!,resultCategories!, nil)
            case .failure(let error):
                print(error)
                completion(nil,nil,error.localizedDescription)
                //self.view.makeToast(error.localizedDescription, duration: 10.0, position: .center)
            }
        }

    }

    func saveDataByRealm(places: [Place],categories: [Category]){
        let realm = try! Realm()
        saveCategoryByRealm(realm: realm, categories: categories)
        savePlaceByRealm(realm: realm, places: places, categories: categories)
    }

    func saveCategoryByRealm(realm: Realm, categories: [Category]){
        for category in categories{
            try! realm.write{
                let categoryListRealm = CategoryListRealm()
                categoryListRealm.id = category.id!
                categoryListRealm.name = category.name!
                categoryListRealm.icon = category.icon!
                categoryListRealm.picture = category.picture!
                realm.add(categoryListRealm)
            }
        }
    }

    func savePlaceByRealm(realm: Realm, places: [Place], categories: [Category])  {
        for place in places{
            try! realm.write {
                let placeRealm = PlaceRealm()
                placeRealm.id = place.id!
                placeRealm.name = place.name!
                placeRealm.description_1 = place.description!
                placeRealm.rate = place.rate!
                placeRealm.description_2 = place.description_2!
                placeRealm.phone = place.phone!
                placeRealm.cost_text = place.cost_text!
                let categoryListRealm = List<CategoryRealm>()
                for item in place.category_id!{
                    if let i = categories.index( where: {$0.id == item}){
                        let category = categories[i]
                        let categoryReal = CategoryRealm()
                        categoryReal.name = category.name!
                        categoryReal.id = category.id!
                        categoryReal.icon = category.icon!
                        categoryReal.picture = category.picture!
                        categoryListRealm.append(categoryReal)
                    }
                }
                let photosRealm = List<StringObject>()
                for photo in place.photos!{
                    let stringObject = StringObject()
                    stringObject.value = photo
                    photosRealm.append(stringObject)
                }
                placeRealm.photos = photosRealm
                placeRealm.categories = categoryListRealm
                realm.add(placeRealm)
            }
        }
        
    }


}
