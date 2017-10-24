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
//                categoryNameLabel.removeConstraints(categoryNameLabel.constraints)
//                categoryNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21.0).isActive = true
//                categoryNameLabel.rightAnchor.constraint(equalTo: headerVeiw.rightAnchor, constant: 16.0).isActive = true
//                categoryNameLabel.leftAnchor.constraint(equalTo: categoryImg.rightAnchor, constant: 16.0).isActive = true
//                categoryNameLabel.topAnchor.constraint(equalTo: headerVeiw.topAnchor, constant: 3.0).isActive = true
//                categoryNameLabel.bottomAnchor.constraint(equalTo: headerVeiw.bottomAnchor, constant: 3.0).isActive = true
                
            }
            else{
                self.saleLabel.text = viewModel.saleString
            }
            distanceLabel.text = viewModel.distance
            
        }
    }
    
    func initConstraint(){
        categoryNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21.0).isActive = true
        categoryNameLabel.rightAnchor.constraint(equalTo: saleBackground.leftAnchor, constant: 16.0).isActive = true
        categoryNameLabel.leftAnchor.constraint(equalTo: categoryImg.rightAnchor, constant: 16.0).isActive = true
        categoryNameLabel.topAnchor.constraint(equalTo: headerVeiw.topAnchor, constant: 3.0).isActive = true
        categoryNameLabel.bottomAnchor.constraint(equalTo: headerVeiw.bottomAnchor, constant: 3.0).isActive = true
    }
    
    func initView(){
        self.categoryNameLabel.text = ""
        self.placeNameLabel.text = ""
        self.placeDescriptionLabel.text = ""
        self.saleLabel.text = ""
        self.saleLabel.isHidden = false
        self.saleBackground.isHidden = false
        //initConstraint()
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
