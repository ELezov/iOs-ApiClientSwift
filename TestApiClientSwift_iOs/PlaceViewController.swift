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
import Agrume
import Kingfisher
import RealmSwift

class PlaceViewController: UIViewController {
    @IBOutlet weak var namePlaceLabel: UILabel!
    @IBOutlet weak var descriptionPlaceLabel: UILabel!
    @IBOutlet weak var categoryTypeImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var placeImageView: UIImageView!

    var place: Place?
    var category: Category?
    var identifity = "PlaceViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        if let place = place{
            navigationItem.title = place.name
            namePlaceLabel.text = place.name
            descriptionPlaceLabel.text = place.description
            placeImageView.kf.setImage(with: URL(string: BASE_URL_API + (place.photos?[0])!))
            ratingControl.rating = place.rate ?? 3

            if let category = category{
                categoryTypeImageView.kf.setImage(with: URL(string: BASE_URL_API + category.icon!))
            }
        }

//        let places = try! Realm().objects(PlaceRealm.self)
//        print("Count Realm Places", String(describing: places.count))
//
//        for place in places{
//            let categories = place.categories
//            for category in categories{
//                print(place.name, category.name)
//            }
//        }



        let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.tappedMe))
        placeImageView.addGestureRecognizer(tap)
        placeImageView.isUserInteractionEnabled = true

    }

    

    func tappedMe(){
        print("HO-HO-HO")
        let urls = place?.photos
        let agrume = Agrume(imageUrls: convertStringToUrlArray(urls: (place?.photos)!))
        agrume.showFrom(self)
    }

    func convertStringToUrlArray(urls: [String]) -> [URL] {
        var urlArrays = [URL]()
        for item in urls{
            let url = URL(string: BASE_URL_API + item)
            urlArrays.append(url!)
        }
        return urlArrays
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : Navigation
    @IBOutlet weak var cancelBtn: UIBarButtonItem!

    @IBAction func cancelActionBtn(_ sender: UIBarButtonItem) {
        if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The PlaceViewController is not inside a navigation controller")
        }
    }
    

}
