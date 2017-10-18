import ObjectMapper
import Alamofire


class NetworkManager{
    
    func getPlace(_ completion:@escaping ([Place]?, [Category]?, String?) -> Void) {
        let request = Network.shared.request(endpoint: PlaceService.getPlaces){
            response in
            if response.result.isSuccess {
                let baseresult = Mapper<ApiBaseResult>().map(JSONObject: response.result.value)
                saveDataByRealm(places: (baseresult?.places)!, categories: (baseresult?.categories)!)
                completion(baseresult?.places,baseresult?.categories, nil)
            } else{
                completion(nil,nil, response.error?.localizedDescription)
            }
        }
    }
    
    func  getInfoPlaceById(id: Int){
        let request = Network.shared.request(endpoint: PlaceService.infoPlace(id: String(id))){
            response in
            if response.result.isSuccess {
                let result = Mapper<Place>().map(JSONObject: response.result.value)
            }
        }
    }
    
    func logIn(name: String, password: String, _ completion:@escaping (Bool) -> Void){
        let request = Network.shared.request(endpoint: LoginService.logIn(name: name, password: password)){
            response in
            if response.result.isSuccess{
                do{
                    let json = try JSONSerialization.jsonObject(with: response.data!) as? [String: Any]
                    let token = json?["token"] as? String
                    if  token != nil{
                        completion(true)
                    } else{
                        completion(false)
                    }
                    
                } catch{
                    print(error)
                    completion(false)
                }
            } else{
                print(response.error)
                completion(false)
            }
        }
    }
}
