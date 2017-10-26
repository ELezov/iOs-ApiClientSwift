import ObjectMapper
import Alamofire


class NetworkManager{
    
    func getPlace(_ completion:@escaping ([Place]?, [Category]?, String?) -> Void) {
        _ = Network.shared.request(endpoint: PlaceService.getPlaces){
            response in
            if response.result.isSuccess {
                let baseresult = Mapper<ApiBaseResult>().map(JSONObject: response.result.value)
                completion(baseresult?.places,baseresult?.categories, nil)                
            } else {
                completion(nil,nil, response.error?.localizedDescription)
            }
        }
    }
    
    func  getInfoPlaceById(id: Int){
        _ = Network.shared.request(endpoint: PlaceService.infoPlace(id: String(id))){
            response in
            if response.result.isSuccess {
                let result = Mapper<Place>().map(JSONObject: response.result.value)
            }
        }
    }
    
    func logIn(name: String, password: String, _ completion:@escaping (Bool, String) -> Void){
        _ = Network.shared.request(endpoint: LoginService.logIn(name: name, password: password)){
            response in
            switch(response.result){
            case .success(let value):
                
                do{
                    let json = try JSONSerialization.jsonObject(with: response.data!) as? [String: Any]
                    let token = json?["token"] as? String
                    if  token != nil{
                        completion(true, token!)
                    } else{
                        completion(false, NSLocalizedString("USER_DATA_ERROR", comment: "Вы предоставили неверные данные. Попробуйте снова."))
                    }
                } catch{
                    print(error)
                    completion(false, NSLocalizedString("UNKNOWN_ERROR", comment: "Неизвестная ошибка. Попробуйте позже."))
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false, NSLocalizedString("INTERNET_ERROR", comment: "У вас отстутствует подключение к интернету. Включите интернет и попробуйте еще раз"))
            }
        }
    }
}
