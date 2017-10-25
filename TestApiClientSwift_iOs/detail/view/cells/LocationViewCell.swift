//
//  LocationViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 17.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelLocationItem else {
                return
            }
            let distance = getStringDistance(distance: item.distance) + " "
            if (item.addressPlace == ""){
                self.addressLabel.text = distance
            } else {
                self.addressLabel.text = distance + "| " + item.addressPlace
            }
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
