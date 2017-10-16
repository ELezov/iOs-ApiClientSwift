import Alamofire

enum PlaceService{
    case getPlaces
    case infoPlace(id: String)
}

extension PlaceService: Endpoint{
    
    internal var headers: HTTPHeaders{
        return ["Authorization" : "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"]
    }
    
    var baseURL: String{
        switch  self {
        case .getPlaces:
            return "http://138.68.68.166:9999/api/1"
        case .infoPlace:
            return "http://138.68.68.166:9999/api/1"
        }
    }
    
    var path: String{
        switch self{
        case .getPlaces: return "/content"
        case .infoPlace(let id): return "/point/\(id)"
        }
        
    }
    
    var method: HTTPMethod{
        switch self{
        case.getPlaces: return .get
        case .infoPlace: return .get
        }
    }
}

