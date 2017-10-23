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
    static let id = "PlaceTableViewCellXib"
    
    weak var viewModel: PlaceTableCellViewModel! {
        didSet{
            initView()
            self.categoryImg.kf.setImage(with: URL(string: BASE_URL_API+viewModel.categoryImgUrl!))
            self.categoryNameLabel.text = viewModel.categoryTitle
            self.placeNameLabel.text = viewModel.placeTitle
            self.placeDescriptionLabel.text = viewModel.placeDescription
            if viewModel.saleString == "0" {
                self.saleLabel.isHidden = true
                self.saleBackground.isHidden = true
            }
            else{
                self.saleLabel.text = viewModel.saleString
            }
            
        }
    }
    
    func initView(){
        self.categoryNameLabel.text = ""
        self.placeNameLabel.text = ""
        self.placeDescriptionLabel.text = ""
        self.saleLabel.text = ""
        self.saleLabel.isHidden = false
        self.saleBackground.isHidden = false
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