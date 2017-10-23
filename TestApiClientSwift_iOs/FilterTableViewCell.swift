//
//  FilterTableViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    static let id = "FilterTableViewCell"
    
    weak var viewModel: FilterTableCellViewModel! {
        didSet{
            initView()
            self.categoryImage.kf.setImage(with: URL(string: BASE_URL_API+viewModel.categoryImgUrl!))
            self.nameCategoryLabel.text = viewModel.nameCategory
        }
    }
    
    func initView(){
        nameCategoryLabel.text = ""
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
