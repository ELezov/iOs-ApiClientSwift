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
    static let id = "PlaceDetailsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        let backImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    func initViews(){
        initTable()
        registerXIBs()
        initFavoriteButton()
    }
    
    func initTable(){
        //настраиваем tableView
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.contentInset = UIEdgeInsets(top: 60.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func registerXIBs(){
        //Регистрация XIB
        tableView?.register(PhotoDetailViewCell.nib, forCellReuseIdentifier: PhotoDetailViewCell.identifier)
        tableView?.register(HeaderPlaceViewCell.nib, forCellReuseIdentifier: HeaderPlaceViewCell.identifier)
        tableView?.register(DescriptionViewCell.nib, forCellReuseIdentifier: DescriptionViewCell.identifier)
        tableView?.register(TimeTableViewCell.nib, forCellReuseIdentifier: TimeTableViewCell.identifier)
        tableView?.register(VisitingPriceCell.nib, forCellReuseIdentifier: VisitingPriceCell.identifier)
        tableView?.register(PhoneViewCell.nib, forCellReuseIdentifier: PhoneViewCell.identifier)
        tableView?.register(LocationViewCell.nib, forCellReuseIdentifier: LocationViewCell.identifier)
        tableView?.register(MapViewCell.nib, forCellReuseIdentifier: MapViewCell.identifier)
    }
    
    func initFavoriteButton(){
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
    func makeCallPhone() {
        if let phone = viewModel?.place.phone {
            if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url){
                if #available(iOS 10, *){
                    UIApplication.shared.open(url)
                }else {
                    UIApplication.shared.openURL(url)
                }
                print("1",url.description)
            }
        }
    }
    
    func makeRoute(){
        if let latitude = viewModel?.place.latitude,
            let longitude = viewModel?.place.longitude {
            if let url = URL(string: "yandexmaps://build_route_on_map/?lat_from=54.709400&lon_from=20.427640&lat_to=\(latitude)&lon_to=\(longitude)"), UIApplication.shared.canOpenURL(url){
                if #available(iOS 10, *){
                    UIApplication.shared.open(url)
                }else {
                    UIApplication.shared.openURL(url)
                }
                print("1",url.description)
            }
        }
    }
    
    //открытие YandexMapViewVC
    func openYandexMapView(){
        self.performSegue(withIdentifier: YandexMapViewController.idSegueShow, sender: self)
    }
    
    //Открытие галереи
    func showMailGallery(){
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        if let photos = viewModel?.place.photos?.count{
            let headerView = CounterView(frame: frame, currentIndex: 0, count: (viewModel?.place.photos?.count)!)
            let galleryViewController = GalleryViewController(startIndex: 0, itemsDataSource: self, configuration: galleryConfiguration())
            
            galleryViewController.headerView = headerView
            galleryViewController.launchedCompletion = { print("LAUNCHED") }
            galleryViewController.closedCompletion = { print("CLOSED") }
            galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }
            
            galleryViewController.landedPageAtIndexCompletion = { [weak self ] index in
                print("LANDED AT INDEX: \(index)")
                headerView.count = (self?.viewModel?.place.photos?.count)!
                headerView.currentIndex = index
            }
            
            self.presentImageGallery(galleryViewController)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case YandexMapViewController.idSegueShow:
            guard let yandexMapVC = segue.destination as? YandexMapViewController  else {
                fatalError("Unexpected destination:\(segue.destination)")
            }
            yandexMapVC.place = viewModel?.place
        default:
            fatalError("Global prepare Error in PlaceTableViewController")
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    

}



