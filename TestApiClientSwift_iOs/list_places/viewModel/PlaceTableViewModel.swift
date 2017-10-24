import Foundation
import RealmSwift
import CoreLocation


class PlaceTableViewModel{
    var placeManager: PlaceManager!
    fileprivate var cellsArray = [PlaceTableCellViewModel]()
    fileprivate var placeArray: [Place]!
    var categoriesArray: [Category]!
    var detailsNewViewModel: DetailsViewModel!
    var error: String?
    var selectedRows = [Int]()
    
    //Обращаемся за получением списка мест
    func updatePlace(_ completion:@escaping () -> Void){
        cellsArray.removeAll()
        placeManager.getPlaces{ [weak self] (placeArray, categoriesArray, error) -> Void in
            self?.placeArray = placeArray
            self?.categoriesArray = categoriesArray
            self?.selectedRows = [Int]()
            
            if categoriesArray != nil {
                let count = (self?.categoriesArray.count)! - 1
                for index in 0...count{
                    self?.selectedRows.append(index)
                }
            }
            
            self?.error = error
            if self?.error == nil{
                for placeObject in placeArray!{
                    self?.cellsArray.append(PlaceTableCellViewModel(place: placeObject, categories: categoriesArray!))
                }
            }
            completion()
        }
    }
    
    //обращаемся за получение фильтрованных данных
    func updateFilter(ids: [Int], _ completion:@escaping () -> Void){
        cellsArray.removeAll()
        let dbHelper = DbHelper()
        dbHelper.getPlacesByIdsCategory(ids: ids){ [weak self] (places, categories) -> Void in
            self?.placeArray = places
            self?.categoriesArray = categories
            for place in places!{
                self?.cellsArray.append(PlaceTableCellViewModel(place: place, categories: categories!))
            }
            completion()
        }
    }
    
    //обновляем расстояния до точек
    func updateDistanceToPlaces(latitude: Double, longitude: Double, _ completion:@escaping () -> Void){
        cellsArray.removeAll()
        for place in self.placeArray{
            place.distance = getDistance(lat1: latitude, lon1: longitude, lat2: place.latitude!, lon2: place.longitude!)
        }
        self.placeArray = self.placeArray.sorted(by: { $0.distance < $1.distance })
        for place in self.placeArray{
            self.cellsArray.append(PlaceTableCellViewModel(place: place, categories: self.categoriesArray))
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
    
    func getDetailsNewModel(_ index: Int) -> DetailsViewModel{
        self.detailsNewViewModel = DetailsViewModel(place: placeArray[index], categories: categoriesArray)
        return self.detailsNewViewModel
    }
    
    func getFilterNewModel() -> FilterViewModel{
        let filterViewModel = FilterViewModel(categories: self.categoriesArray, selectedRows: self.selectedRows)
        return filterViewModel
    }

    required init(placeManager: PlaceManager){
        self.placeManager = placeManager
    }

}

