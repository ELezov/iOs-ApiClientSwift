import Foundation

class PlaceTableViewModel{
    weak var placeManager: PlaceManager!
    fileprivate var cellsArray = [PlaceTableCellViewModel]()
    fileprivate var placeArray: [Place]!
    fileprivate var categoriesArray: [Category]!
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
