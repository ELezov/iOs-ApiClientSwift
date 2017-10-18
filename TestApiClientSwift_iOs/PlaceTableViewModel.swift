import Foundation
import RealmSwift

class PlaceTableViewModel{
    var placeManager: PlaceManager!
    fileprivate var cellsArray = [PlaceTableCellViewModel]()
    fileprivate var placeArray: [Place]!
    var categoriesArray: [Category]!
    var detailsViewModel: PlaceDetailsViewModel!
    var detailsNewViewModel: DetailsViewModel!
    var error: String?

    func updatePlace(_ completion:@escaping () -> Void){
        cellsArray.removeAll()
        placeManager.getPlaces{(placeArray, categoriesArray, error) -> Void in
            self.placeArray = placeArray
            self.categoriesArray = categoriesArray
            self.error = error
            if self.error == nil{
                for placeObject in placeArray!{
                    self.cellsArray.append(PlaceTableCellViewModel(place: placeObject, categories: categoriesArray!))
                }
            }

            completion()
        }
    }
    
    func updateFilter(ids: [Int], _ completion:@escaping () -> Void){
        cellsArray.removeAll()
        placeManager.getDataByFilter(ids: ids){ (places, categories) -> Void in
            self.placeArray = places
            self.categoriesArray = categories
            for placeObject in self.placeArray!{
                self.cellsArray.append(PlaceTableCellViewModel(place: placeObject, categories: self.categoriesArray!))
            }
        
        }
        completion()
    }
    
    func  getDataByFilter(ids: [Int], _ completion:@escaping () -> Void){
        
        cellsArray.removeAll()
        let converter = Converter()
        let realm = try! Realm()
        let categoriesList = Array(realm.objects(CategoryListRealm.self))
        let categories = converter.arrayRealmListCategoryToCategory(categoriesListRealm: categoriesList)
        let placesRealm = Array(realm.objects(PlaceRealm.self))
        let placesDB = converter.arrayRealmPlaceToPlace(placesRealm: placesRealm)
        var places = [Place]()
        for item in placesDB{
            for id in ids{
                if (item.categoryId?.contains(id))!{
                    places.append(item)
                    break
                }
            }
        }
        self.placeArray = places
        self.categoriesArray = categories
        for placeObject in placeArray!{
            self.cellsArray.append(PlaceTableCellViewModel(place: placeObject, categories: categoriesArray!))
        }
        completion()
    }
    

    func numberOfPlaces() -> Int{
        return cellsArray.count
    }

    func cellViewModel(_ index: Int) -> PlaceTableCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }

    func getDetailsViewModel(_ index: Int) -> PlaceDetailsViewModel{
        self.detailsViewModel = PlaceDetailsViewModel(place: placeArray[index], categories: categoriesArray)
        return self.detailsViewModel
    }
    
    func getDetailsNewModel(_ index: Int) -> DetailsViewModel{
        self.detailsNewViewModel = DetailsViewModel(place: placeArray[index], categories: categoriesArray)
        return self.detailsNewViewModel
    }

    required init(placeManager: PlaceManager){
        self.placeManager = placeManager
    }
}
