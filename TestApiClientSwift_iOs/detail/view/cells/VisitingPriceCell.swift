//
//  VisitingTimeDetailsCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class VisitingPriceCell: BaseTableViewCell {

    @IBOutlet weak var visitingPriceLabel: UILabel!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelVisitPriceItem else {
                return
            }
            visitingPriceLabel.text = ""
            visitingPriceLabel.textColor = UIColor.amberCardText
            let costVisitTitle = "VISIT_COST".localized
            let costAttributedText = NSMutableAttributedString(string: costVisitTitle  + item.visitingPriceText)
            costAttributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans-Semibold", size: 17.0)!, range: NSRange(location: 0, length: costVisitTitle.characters.count))
            
            visitingPriceLabel.attributedText = costAttributedText
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
