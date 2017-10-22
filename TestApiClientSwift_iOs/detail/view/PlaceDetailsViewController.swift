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

class PlaceDetailsViewController: UIViewController{
    var viewModel: DetailsViewModel?
    var isFavorite = false
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView?
    var imagesUrl = [String]()
    static let idSegueShow = "ShowDetail"    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagesUrl = (viewModel?.place.photos)!
        InitViews()
    }
    
    func InitViews(){
        //настраиваем tableView
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        //Регистрация XIB
        tableView?.register(PhotoDetailViewCell.nib, forCellReuseIdentifier: PhotoDetailViewCell.identifier)
        tableView?.register(HeaderPlaceViewCell.nib, forCellReuseIdentifier: HeaderPlaceViewCell.identifier)
        tableView?.register(DescriptionViewCell.nib, forCellReuseIdentifier: DescriptionViewCell.identifier)
        tableView?.register(TimeTableViewCell.nib, forCellReuseIdentifier: TimeTableViewCell.identifier)
        tableView?.register(VisitingPriceCell.nib, forCellReuseIdentifier: VisitingPriceCell.identifier)
        tableView?.register(PhoneViewCell.nib, forCellReuseIdentifier: PhoneViewCell.identifier)
        tableView?.register(LocationViewCell.nib, forCellReuseIdentifier: LocationViewCell.identifier)
        tableView?.register(MapViewCell.nib, forCellReuseIdentifier: MapViewCell.identifier)
        //инициализируем кнопку добавления в Избранное
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "emptyFavorite"), for: .normal)
        button.addTarget(self, action: #selector(PlaceDetailsViewController.favoriteButtonAction), for: .touchUpInside)
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        if let id = identifier {
            if id == YandexMapViewController.idSegueShowUnwind{
                let unwindSegue = FirstCustomSegueUnwind(identifier: id, source: fromViewController, destination: toViewController, performHandler: {() -> Void in
                })
                return unwindSegue
            }
        }
        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //включаем скролящийся navbar
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView!, delay: 0.0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //выключаем скролящийся navbar
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    //функция добавления в избранное
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
    //функция совершения мобильного вызова
    func makeCallPhone(){
        if let url = URL(string: "tel://\(viewModel?.place.phone)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else {
                UIApplication.shared.openURL(url)
            }
            print("1",url.description)
        }
    }
    
    //открытие YandexMapViewVC
    func openYandexMapView(){
        self.performSegue(withIdentifier: YandexMapViewController.idSegueShow, sender: self)
    }
    
    //Открытие галереи
    func showMailGallery(){
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        let headerView = CounterView(frame: frame, currentIndex: 0, count: imagesUrl.count)
        let galleryViewController = GalleryViewController(startIndex: 0, itemsDataSource: self, configuration: galleryConfiguration())
        
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
        case YandexMapViewController.idSegueShow:
            guard let yandexMapVC = segue.destination as? YandexMapViewController  else {
                fatalError("Unexpected destination:\(segue.destination)")
            }
            
            yandexMapVC.latitude = (viewModel?.place.latitude)!
            yandexMapVC.longitude = (viewModel?.place.longitude)!
        default:
            fatalError("Global prepare Error in PlaceTableViewController")
        }
    }

}



