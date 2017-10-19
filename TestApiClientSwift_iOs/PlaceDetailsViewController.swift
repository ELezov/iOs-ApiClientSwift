//
//  PlaceDetailsViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import Agrume
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
    }
    
    func InitViews(){
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        button.setImage(UIImage(named: "emptyFavorite"), for: .normal)
        button.addTarget(self, action: Selector(("favoriteButtonAction")), for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView?.layer.backgroundColor = UIColor.clear.cgColor
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
    
    func openGalleryAction(){
        let urls = viewModel?.placeImgUrl
        let converter = Converter()
        let agrume = Agrume(imageUrls: converter.convertStringToUrlArray(urls: urls!))
        agrume.showFrom(self)
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
        button.addTarget(self, action: Selector(("favoriteButtonAction")), for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = button
        self.navigationItem.rightBarButtonItem = barButton
    }
   
    
}

extension PlaceDetailsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel?.items[indexPath.section]
        let type = item?.type
        switch type!{
        case DetailsViewModelItemType.placePhoto:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDetailViewCell.identifier, for: indexPath) as? PhotoDetailViewCell{
                cell.item = item
                let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceDetailsViewController.showMailGallery))
                cell.addGestureRecognizer(tap)
                cell.isUserInteractionEnabled = true
                return cell
            }
            
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderPlaceViewCell.identifier, for: indexPath) as? HeaderPlaceViewCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCell.identifier, for: indexPath) as? DescriptionViewCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .timeTable:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .visitingPrice:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VisitingPriceCell.identifier, for: indexPath) as? VisitingPriceCell{
                cell.item = item
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .phoneView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhoneViewCell.identifier, for: indexPath) as? PhoneViewCell{
                cell.item = item
                let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceDetailsViewController.makeCallPhone))
                cell.addGestureRecognizer(tap)
                cell.isUserInteractionEnabled = true
                return cell
            }
        case .location:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LocationViewCell.identifier, for: indexPath) as? LocationViewCell{
                cell.item = item
                return cell
            }
            
        }
        return UITableViewCell()
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
    }
    
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
    
    func galleryConfiguration() -> GalleryConfiguration {
        
        return [
            GalleryConfigurationItem.deleteButtonMode(.none),
            GalleryConfigurationItem.closeButtonMode(.builtIn),
            GalleryConfigurationItem.pagingMode(.standard),
            GalleryConfigurationItem.presentationStyle(.displacement),
            GalleryConfigurationItem.hideDecorationViewsOnLaunch(false),
            GalleryConfigurationItem.overlayColor(UIColor(white: 0.035, alpha: 1)),
            GalleryConfigurationItem.overlayColorOpacity(1),
            GalleryConfigurationItem.overlayBlurOpacity(1),
            GalleryConfigurationItem.overlayBlurStyle(UIBlurEffectStyle.light),
            GalleryConfigurationItem.swipeToDismissThresholdVelocity(300),
            GalleryConfigurationItem.doubleTapToZoomDuration(0.15),
            GalleryConfigurationItem.blurPresentDuration(0.5),
            GalleryConfigurationItem.blurPresentDelay(0),
            GalleryConfigurationItem.colorPresentDuration(0.25),
            GalleryConfigurationItem.colorPresentDelay(0),
            GalleryConfigurationItem.blurDismissDuration(0.1),
            GalleryConfigurationItem.blurDismissDelay(0.4),
            GalleryConfigurationItem.colorDismissDuration(0.45),
            GalleryConfigurationItem.colorDismissDelay(0),
            GalleryConfigurationItem.itemFadeDuration(0.3),
            GalleryConfigurationItem.decorationViewsFadeDuration(0.15),
            GalleryConfigurationItem.rotationDuration(0.15),
            GalleryConfigurationItem.displacementDuration(0.55),
            GalleryConfigurationItem.reverseDisplacementDuration(0.25),
            GalleryConfigurationItem.displacementTransitionStyle(.springBounce(0.7)),
            GalleryConfigurationItem.displacementTimingCurve(.linear),
            GalleryConfigurationItem.thumbnailsButtonMode(.none),
            GalleryConfigurationItem.statusBarHidden(true),
            GalleryConfigurationItem.displacementKeepOriginalInPlace(false),
            GalleryConfigurationItem.displacementInsetMargin(50)
        ]
    }
    
    
    
}


extension PlaceDetailsViewController: GalleryItemsDataSource{
    
    func itemCount() -> Int {
        
        return imagesUrl.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        let url = URL(string: BASE_URL_API + self.imagesUrl[index])
        return GalleryItem.image{ callback in
            KingfisherManager.shared.retrieveImage(with: url!, options: [], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
                    callback(image)
            })
        }
    }
}
