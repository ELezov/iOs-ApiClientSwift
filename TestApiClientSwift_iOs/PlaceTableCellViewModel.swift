import Foundation

class PlaceTableCellViewModel{
    var placeTitle : String!
    var placeDescription : String!
    var categoryImgUrl: String!
    var categoryTitle : String!

    required init(place: Place, categories: [Category]){
        self.placeTitle = place.name
        self.placeDescription = place.description
        let category = categories.first(where: {$0.id == place.category_id?[0]})
        self.categoryTitle = category?.name
        self.categoryImgUrl = category?.icon
    }
}
