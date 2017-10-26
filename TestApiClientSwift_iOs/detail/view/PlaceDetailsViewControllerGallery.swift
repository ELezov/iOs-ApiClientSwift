//
//  PlaceDetailsViewControllerGallery.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Kingfisher
import ImageViewer

extension PlaceDetailsViewController: GalleryItemsDataSource{
    
    func itemCount() -> Int {
        
        return (viewModel?.place.photos?.count)!
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        let url = URL(string: BASE_URL_API + (viewModel?.place.photos?[index])!)
        let placeholder = UIImage(named: "crown_light")
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
            GalleryConfigurationItem.closeLayout(.pinLeft(12, 12)),
            GalleryConfigurationItem.deleteButtonMode(.none),
            GalleryConfigurationItem.thumbnailsButtonMode(.none),
            GalleryConfigurationItem.swipeToDismissMode(.vertical),
            GalleryConfigurationItem.overlayBlurStyle(.extraLight),
        ]
    }
}
