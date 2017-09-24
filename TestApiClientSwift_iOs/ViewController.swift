//
//  ViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by KODE_H6 on 24.09.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let header : HTTPHeaders = ["Authorization" : "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"]
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("http://138.68.68.166:9999/api/1/content",headers: header).validate().responseObject{
            (response: DataResponse<ApiBaseResult>) in
            switch response.result{
            case .success(let value):
                print(value)
                let resultObject = response.result.value
                if let places = resultObject?.places {
                    print("Size places", places.count)
                    for place in places{
                        print(String(describing: place.name))
                    }
                }



            case .failure(let error):
                print(error)
            }
            
            /*guard let statusCode = response.response?.statusCode else {
                return
            }
            print("statusCode: ", statusCode)

            if (200..<300).contains(statusCode){
                let value = response.result.value
                print("value: ",value ?? "nil")

            }else{
                print("error")
            }*/
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
