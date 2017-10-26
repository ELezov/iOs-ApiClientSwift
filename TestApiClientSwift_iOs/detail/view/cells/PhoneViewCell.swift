//
//  PhoneDetailsViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class PhoneViewCell: UITableViewCell {

    @IBOutlet weak var phoneDetailsLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var phoneIcon: UIImageView!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelPhoneItem else {
                return
            }
            separatorView.backgroundColor = UIColor.amberCardSeparator
            phoneIcon.tintColor = UIColor.amberCardBlue
            phoneDetailsLabel.textColor = UIColor.amberCardText
            phoneDetailsLabel.text = ""
            phoneDetailsLabel.text = item.phoneText
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
