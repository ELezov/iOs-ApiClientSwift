//
//  TableViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 15.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class PlaceTableViewXibCell: UITableViewCell {
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var saleBackground: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeDescriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var headerVeiw: UIView!
    @IBOutlet weak var locationIcon: UIImageView!
    static let id = "PlaceTableViewCellXib"
    
    weak var viewModel: PlaceTableCellViewModel! {
        didSet {
            initView()
            if let categoryImgUrl = viewModel.categoryImgUrl {
                self.categoryImg.kf.setImage(with: URL(string: BASE_URL_API+categoryImgUrl))
            }
            if let categoryTitle = viewModel.categoryTitle {
                self.categoryNameLabel.text = categoryTitle
            }
            if let placeTitle = viewModel.placeTitle {
                self.placeNameLabel.text = placeTitle
            }
            if let placeDescription = viewModel.placeDescription {
                self.placeDescriptionLabel.text = placeDescription
            }
            if let saleString = viewModel.saleString {
                if saleString == "0" {
                    self.saleLabel.isHidden = true
                    self.saleBackground.isHidden = true
                } else {
                    self.saleLabel.text = saleString
                }
            }
            distanceLabel.text = viewModel.distance
        }
    }
    
    func initView() {
        self.categoryNameLabel.text = ""
        self.placeNameLabel.text = ""
        self.placeDescriptionLabel.text = ""
        self.saleLabel.text = ""
        self.saleLabel.isHidden = false
        self.saleBackground.isHidden = false
        self.distanceLabel.textColor = UIColor.amberCardBlue
        self.placeDescriptionLabel.textColor = UIColor.amberCardText
        self.saleBackground.tintColor = UIColor.amberCardBlue
        self.locationIcon.tintColor = UIColor.amberCardBlue
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
