import Alamofire

enum PlaceService{
    case getPlaces
    case infoPlace(id: String)
    case addToFavorite(id: String)
    case deleteFromFavorite(id: String)
    case addToWish(id: String)
    case deleteFromWish(id: String)
    case addToVisited(id: String)
}

extension PlaceService: Endpoint{
    
    internal var headers: HTTPHeaders{
        var resultToken = "Token "
        if let token: String = UserDefaults.standard.string(forKey: "userToken") {
            resultToken += token
        }
        return ["Authorization": resultToken]
    }
    
    var baseURL: String{
        switch  self {
        case .getPlaces:
            return "http://138.68.68.166:9999/api/1"
        case .infoPlace:
            return "http://138.68.68.166:9999/api/1"
        case .addToFavorite:
            return "http://138.68.68.166:9999/api/1"
        case .deleteFromFavorite:
            return "http://138.68.68.166:9999/api/1"
        case .addToWish:
            return "http://138.68.68.166:9999/api/1"
        case .deleteFromWish:
            return "http://138.68.68.166:9999/api/1"
        case .addToVisited:
            return "http://138.68.68.166:9999/api/1"
        }
    }
    
    var path: String{
        switch self{
        case .getPlaces: return "/content"
        case .infoPlace(let id): return "/point/\(id)"
        case .addToFavorite(let id): return "/favorites/\(id)"
        case .deleteFromFavorite(let id): return "/favorites/\(id)"
        case .addToWish(let id): return "/wish/\(id)"
        case .deleteFromWish(let id): return "/wish/\(id)"
        case .addToVisited(let id): return "/visited/\(id)"
        }
        
    }
    
    var method: HTTPMethod{
        switch self{
        case .getPlaces: return .get
        case .infoPlace: return .get
        case .addToFavorite: return .post
        case .deleteFromFavorite: return .delete
        case .addToWish: return .post
        case .deleteFromWish: return .delete
        case .addToVisited: return .post
        }
    }
}

