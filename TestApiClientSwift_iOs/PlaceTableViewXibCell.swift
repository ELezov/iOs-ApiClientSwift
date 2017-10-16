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
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeDescriptionLabel: UILabel!
    
    weak var viewModel: PlaceTableCellViewModel!{
        didSet{
            self.categoryImg.kf.setImage(with: URL(string: BASE_URL_API+viewModel.categoryImgUrl!))
            self.categoryNameLabel.text = viewModel.categoryTitle
            self.placeNameLabel.text =  viewModel.placeTitle
            self.placeDescriptionLabel.text = viewModel.placeDescription
            self.saleLabel.text = viewModel.saleString

        }
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
