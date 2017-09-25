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
        }




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
