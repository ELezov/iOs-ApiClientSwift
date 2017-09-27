import Foundation

class PlaceTableViewModel{
    weak var placeManager: PlaceManager!
    fileprivate var cellsArray = [PlaceTableCellViewModel]()
    fileprivate var placeArray: [Place]!
    fileprivate var categoriesArray: [Category]!
    var detailsViewModel: PlaceDetailsViewModel!

    func updateWeather(_ completion:@escaping () -> Void){
        cellsArray.removeAll()
        placeManager.getPlaces{(placeArray, categoriesArray) -> Void in
            self.placeArray = placeArray
            self.categoriesArray = categoriesArray
            for placeObject in placeArray{
                self.cellsArray.append(PlaceTableCellViewModel(place: placeObject, categories: categoriesArray))
            }
            completion()
        }
    }

    func numberOfCities() -> Int{
        return cellsArray.count
    }

    func cellViewModel(_ index: Int) -> PlaceTableCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }

    func detailsViewModel(_ index: Int) -> PlaceDetailsViewModel{
        self.detailsViewModel = PlaceDetailsViewModel(place: placeArray[index], categories: categoriesArray)
        return self.detailsViewModel
    }

    required init(placeManager: PlaceManager){
        self.placeManager = placeManager
    }
}
