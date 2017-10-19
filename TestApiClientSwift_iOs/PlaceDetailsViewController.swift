//
//  PlaceDetailsViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import ImageViewer
import Kingfisher

extension UIImageView
{
    func load(_ string: String){
        self.kf.setImage(with: URL(string: BASE_URL_API+string))
    }
}

//extension UIImageView: DisplaceableView {}

class PlaceDetailsViewController: UIViewController{
    var viewModel: DetailsViewModel?
    var isFavorite = false
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView?
    var imagesUrl = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitViews()
        self.imagesUrl = (viewModel?.place.photos)!
        
        //action for gallery
            }
    
    func InitViews(){
        
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        tableView?.register(PhotoDetailViewCell.nib, forCellReuseIdentifier: PhotoDetailViewCell.identifier)
        tableView?.register(HeaderPlaceViewCell.nib, forCellReuseIdentifier: HeaderPlaceViewCell.identifier)
        tableView?.register(DescriptionViewCell.nib, forCellReuseIdentifier: DescriptionViewCell.identifier)
        tableView?.register(TimeTableViewCell.nib, forCellReuseIdentifier: TimeTableViewCell.identifier)
        tableView?.register(VisitingPriceCell.nib, forCellReuseIdentifier: VisitingPriceCell.identifier)
        tableView?.register(PhoneViewCell.nib, forCellReuseIdentifier: PhoneViewCell.identifier)
        tableView?.register(LocationViewCell.nib, forCellReuseIdentifier: LocationViewCell.identifier)
        tableView?.register(MapViewCell.nib, forCellReuseIdentifier: MapViewCell.identifier)
        
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        button.setImage(UIImage(named: "emptyFavorite"), for: .normal)
        button.addTarget(self, action: #selector(PlaceDetailsViewController.favoriteButtonAction), for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
    }
    
//    override func viewWillLayoutSubviews() {
//        self.tableView?.layer.backgroundColor = UIColor.clear.cgColor
//    }
    
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        if let id = identifier {
            if id == "idFirstSegueUnwind"{
                let unwindSegue = FirstCustomSegueUnwind(identifier: id, source: fromViewController, destination: toViewController, performHandler: {() -> Void in
                    
                })
                return unwindSegue
            }
        }
        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView!, delay: 0.0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
  
    func favoriteButtonAction() {
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        if isFavorite {
            button.setImage(UIImage(named: "emptyFavorite"), for: .normal)
            isFavorite = false
        }else{
           button.setImage(UIImage(named: "filledFavorite"), for: .normal)
            isFavorite = true
        }
        button.addTarget(self, action: #selector(PlaceDetailsViewController.favoriteButtonAction), for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func makeCallPhone(){
        if let url = URL(string: "tel://\(viewModel?.place.phone)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else {
                UIApplication.shared.openURL(url)
            }
            print("1",url.description)
        }
        print(viewModel?.place.phone)
    }
    
    func openYandexMapView(){
        print("OpenMap")
        let id = "showMapCustom"
        let identifier = "ShowMap"
        self.performSegue(withIdentifier: id, sender: self)
        
        /*let vc = YandexMapViewController()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: false)*/
    }
    
    func showMailGallery(){
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        let headerView = CounterView(frame: frame, currentIndex: 0, count: imagesUrl.count)
        let galleryViewController = GalleryViewController(startIndex: 0, itemsDatasource: self, configuration: galleryConfiguration())
        
        galleryViewController.headerView = headerView
        galleryViewController.launchedCompletion = { print("LAUNCHED") }
        galleryViewController.closedCompletion = { print("CLOSED") }
        galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }
        
        galleryViewController.landedPageAtIndexCompletion = { index in
            
            print("LANDED AT INDEX: \(index)")
            
            headerView.count = self.imagesUrl.count
            headerView.currentIndex = index
        }
        
        
        self.presentImageGallery(galleryViewController)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "ShowMap":
            guard let yandexMapVC = segue.destination as? YandexMapViewController  else {
                fatalError("Unexpected destination:\(segue.destination)")
            }
            
            yandexMapVC.latitude = (viewModel?.place.latitude)!
            yandexMapVC.longitude = (viewModel?.place.longitude)!
        case "showMapCustom":
            print("Custon")
        default:
            fatalError("Global prepare Error in PlaceTableViewController")
        }
    }

}



