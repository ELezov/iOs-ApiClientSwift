import Foundation

class PlaceTableCellViewModel{
    var placeTitle : String?
    var placeDescription : String?
    var categoryImgUrl: String?
    var categoryTitle : String?
    var saleString: String?

    required init(place: Place, categories: [Category]){
        self.placeTitle = place.name
        self.placeDescription = place.description
        let category = categories.first(where: {$0.id == place.categoryId?[0]})
        self.categoryTitle = category?.name
        self.categoryImgUrl = category?.icon
        if ((place.discountMax == nil)||(place.discountMax==0)){
            self.saleString = "0"
        }
        else {
             self.saleString = "-".appending(String(describing: place.discountMax!) + "%")
        }
        
    }
}
