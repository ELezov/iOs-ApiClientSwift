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
        if let token: String = UserDefaults.standard.string(forKey: userToken) {
            resultToken += token
        }
        return ["Authorization": resultToken]
    }
    
    var baseURL: String{
        switch  self {
        case .getPlaces:
            return HOST_URL_API
        case .infoPlace:
            return HOST_URL_API
        case .addToFavorite:
            return HOST_URL_API
        case .deleteFromFavorite:
            return HOST_URL_API
        case .addToWish:
            return HOST_URL_API
        case .deleteFromWish:
            return HOST_URL_API
        case .addToVisited:
            return HOST_URL_API
        }
    }
    
    var path: String{
        switch self{
        case .getPlaces: return PATH_CONTENT_URL
        case .infoPlace(let id): return PATH_POINT_URL + "/\(id)"
        case .addToFavorite(let id): return PATH_FAVORITES_URL + "/\(id)"
        case .deleteFromFavorite(let id): return PATH_FAVORITES_URL + "/\(id)"
        case .addToWish(let id): return PATH_WISH_URL + "\(id)"
        case .deleteFromWish(let id): return PATH_WISH_URL + "/\(id)"
        case .addToVisited(let id): return PATH_VISITED_URL + "/\(id)"
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

