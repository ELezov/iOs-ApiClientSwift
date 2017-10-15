import Alamofire

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var fullURL: String { get }
    var method: HTTPMethod { get } 
    var encoding: ParameterEncoding { get }
    var body: Parameters { get }
    var headers: HTTPHeaders { get }
}

extension Endpoint {
    

    var encoding: ParameterEncoding {
        return method == .get ? URLEncoding.default : JSONEncoding.default
    }
    
    var fullURL: String {
        return baseURL + path
    }
    
    // A lot of requests don't require parameters
    // so we just set them to be empty
    var body: Parameters {
        return Parameters()
    }
       
}
