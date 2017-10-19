//
//  PlaceDetailVCExtension.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 19.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation
import ImageViewer
import Kingfisher

extension PlaceDetailsViewController: GalleryItemsDatasource{
    
    func itemCount() -> Int {
        
        return imagesUrl.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        let url = URL(string: BASE_URL_API + self.imagesUrl[index])
        let placeholder = UIImage(named: "logo_black")
        return GalleryItem.image{ callback in
            KingfisherManager.shared.retrieveImage(with: url!, options: [], progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
                
                if error == nil{
                    callback(image)
                }
                else {
                    callback(placeholder)
                }
                
                
            })
        }
    }
    
    func galleryConfiguration() -> GalleryConfiguration {
        
        return [
            //GalleryConfigurationItem.closeButtonMode(.builtIn),
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
                cell.isUserInteractionEnabled = false
                return cell
            }
        case .map:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapViewCell.identifier, for: indexPath) as? MapViewCell{
                cell.item = item
                let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceDetailsViewController.openYandexMapView))
                cell.addGestureRecognizer(tap)
                cell.isUserInteractionEnabled = true
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
