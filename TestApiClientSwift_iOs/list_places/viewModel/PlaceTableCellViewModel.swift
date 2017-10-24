import Foundation

class PlaceTableCellViewModel{
    var placeTitle : String?
    var placeDescription : String?
    var categoryImgUrl: String?
    var categoryTitle : String?
    var saleString: String?
    var distance: String?

    required init(place: Place, categories: [Category]){
        // подготавливаем данные для отображения ячейки списка
        self.placeTitle = place.name
        self.placeDescription = place.description
        let category = categories.first(where: {$0.id == place.categoryId?[0]})
        self.categoryTitle = category?.name
//        switch place.distance {
//        case 0:
//            self.distance = "..."
//        case 1...999 :
//            self.distance = String(place.distance) + " м"
//        default:
//            let dist = Double(place.distance) / 1000.0
//            self.distance = String(Double(round(dist * 10) / 10)) + " км"
//        }
        self.distance = getStringDistance(distance: place.distance)
        self.categoryImgUrl = category?.icon
        if ((place.discountMax == nil)||(place.discountMax==0)){
            self.saleString = "0"
        }
        else {
             self.saleString = "-".appending(String(describing: place.discountMax!) + "%")
        }
        
    }
}
