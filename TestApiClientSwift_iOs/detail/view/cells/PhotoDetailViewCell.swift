//
//  PhotoDetailViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 18.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class PhotoDetailViewCell: BaseTableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelPlacePhotoItem else {
                return
            }
            let imagePlaceholder = UIImage(named: "crown_light")
            placeImageView.kf.setImage(with: URL(string: item.photoUrl), placeholder: imagePlaceholder)
        }
    }
    
    override func setData(item: DetailsViewModelItem) {
        self.item = item
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
