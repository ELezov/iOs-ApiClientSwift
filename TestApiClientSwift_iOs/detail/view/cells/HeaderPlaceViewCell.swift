//
//  TableViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 14.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class HeaderPlaceViewCell: UITableViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var ratingView: RatingView!
    
    var item: DetailsViewModelItem? {
        didSet{
            guard let item = item as? DetailsViewModelHeaderItem else {
                return
            }
            categoryImg.kf.setImage(with: URL(string:BASE_URL_API + item.categoryImgUrl))
            categoryNameLabel.text = ""
            placeNameLabel.text = ""
            ratingView.isHidden = false
            categoryNameLabel.text = item.categoryName
            placeNameLabel.text = item.placeName
            if item.rating != 0 {
                ratingView.rating = item.rating
            } else {
                ratingView.isHidden = true
            }
        }
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String{
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        categoryImg.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
