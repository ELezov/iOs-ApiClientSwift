//
//  DescriptionDetailsViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 14.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class DescriptionViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelDescriptionItem else {
                return
            }
            
            descriptionLabel.text = item.descriptionText
        }
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
