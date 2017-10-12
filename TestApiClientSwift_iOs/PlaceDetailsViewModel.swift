import Foundation

class PlaceDetailsViewModel{
    var placeTitle : String!
    var placeDescription : String!
    var phoneText: String!
    var costText: String!
    var placeRate : Int!
    var timeTable: String!
    var placePhotos: [String]!
    var category : Category!
    var categoryTitle : String!
    var categoryImgUrl : String!

    required init(place: Place, categories: [Category]){
        self.placeTitle = place.name
        self.placeDescription = place.description
        self.placeRate = place.rate
        self.placePhotos = place.photos
        self.category = categories.first(where: {$0.id == place.category_id?[0]})
        self.categoryTitle = self.category.name
        self.categoryImgUrl = self.category.icon
        print(place.phone , place.cost_text, place.description_2)
        self.phoneText = place.phone
        self.costText = place.cost_text
        self.timeTable = place.description_2
    }
}
