import Alamofire

enum PlacesEndpoint{
    case getPlaces
}

extension PlacesEndpoint: Endpoint{
    internal var headers: HTTPHeaders{
        return ["Authorization" : "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"]
    }
    
    var baseURL: String{
        switch  self {
        case .getPlaces:
            return "http://138.68.68.166:9999/api/1"
        }
    }
    
    var path: String{
        switch self{
        case .getPlaces:
            return "/content"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case.getPlaces: return .get
        }
    }
}
