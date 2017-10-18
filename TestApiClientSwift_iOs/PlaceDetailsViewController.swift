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
import NYTPhotoViewer

class PlaceDetailsViewController: UIViewController{
    
    var viewModel: DetailsViewModel?
    var photos = PhotosProvider().photos
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonImage = UIImage(named: PrimaryImageName)
        //imageButton?.setBackgroundImage(buttonImage, forState: .Normal)
        
        
        //action for gallery
        tableView?.dataSource = self//viewModel
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
        print("Haha", "oOops")
        let urls = viewModel?.placeImgUrl
        let converter = Converter()
        let agrume = Agrume(imageUrls: converter.convertStringToUrlArray(urls: urls!))
        agrume.showFrom(self)
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
                let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceDetailsViewController.openGalleryAction))
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
        print(viewModel?.place.phone)
    }
}

//extension PlaceDetailsViewController: NYTPhotosViewControllerDelegate{
//    
//    
//    func openNYTGalleryAction(){
//        print("Haha", "oOops")
//        let photosViewController = NYTPhotosViewController(photos: self.photos)
//        photosViewController.delegate = self
//        present(photosViewController, animated: true, completion: nil)
//        
//        let urls = viewModel?.placeImgUrl
//        let converter = Converter()
//        let agrume = Agrume(imageUrls: converter.convertStringToUrlArray(urls: urls!))
//        agrume.showFrom(self)
//    }
//    
//    func updateImagesOnPhotosViewController(photosViewController: NYTPhotosViewController, afterDelayWithPhotos: [ExamplePhoto]) {
//        
//        let delayTime = dispatch_time(dispatch_time_t(DispatchTime.now()), 5 * Int64(NSEC_PER_SEC))
//        
//        dispatch_after(delayTime, DispatchQueue.main) {
//            for photo in self.photos {
//                if photo.image == nil {
//                    photo.image = UIImage(named: PrimaryImageName)
//                    photosViewController.updateImage(for: photo)
//                }
//            }
//        }
//    }
//    
//    // MARK: - NYTPhotosViewControllerDelegate
//    
//    func photosViewController(photosViewController: NYTPhotosViewController, handleActionButtonTappedForPhoto photo: NYTPhoto) -> Bool {
//        
//        if UIDevice.current.userInterfaceIdiom == .Pad {
//            
//            guard let photoImage = photo.image else { return false }
//            
//            let shareActivityViewController = UIActivityViewController(activityItems: [photoImage], applicationActivities: nil)
//            
//            shareActivityViewController.completionWithItemsHandler = {(activityType: String?, completed: Bool, items: [AnyObject]?, error: NSError?) in
//                if completed {
//                    photosViewController.delegate?.photosViewController!(photosViewController, actionCompletedWithActivityType: activityType!)
//                }
//            }
//            
//            shareActivityViewController.popoverPresentationController?.barButtonItem = photosViewController.rightBarButtonItem
//            photosViewController.present(shareActivityViewController, animated: true, completion: nil)
//            
//            return true
//        }
//        
//        return false
//    }
//    
//    func photosViewController(photosViewController: NYTPhotosViewController, referenceViewForPhoto photo: NYTPhoto) -> UIView? {
//        if photo as? ExamplePhoto == photos[NoReferenceViewPhotoIndex] {
//            return nil
//        }
//        return imageButton
//    }
//    
//    func photosViewController(photosViewController: NYTPhotosViewController, loadingViewForPhoto photo: NYTPhoto) -> UIView? {
//        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
//            let label = UILabel()
//            label.text = "Custom Loading..."
//            label.textColor = UIColor.green
//            return label
//        }
//        return nil
//    }
//    
//    func photosViewController(photosViewController: NYTPhotosViewController, captionViewForPhoto photo: NYTPhoto) -> UIView? {
//        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
//            let label = UILabel()
//            label.text = "Custom Caption View"
//            label.textColor = UIColor.white
//            label.backgroundColor = UIColor.red
//            return label
//        }
//        return nil
//    }
//    
//    func photosViewController(photosViewController: NYTPhotosViewController, didNavigateToPhoto photo: NYTPhoto, atIndex photoIndex: UInt) {
//        print("Did Navigate To Photo: \(photo) identifier: \(photoIndex)")
//    }
//    
//    func photosViewController(photosViewController: NYTPhotosViewController, actionCompletedWithActivityType activityType: String?) {
//        print("Action Completed With Activity Type: \(activityType)")
//    }
//
//    
//}
