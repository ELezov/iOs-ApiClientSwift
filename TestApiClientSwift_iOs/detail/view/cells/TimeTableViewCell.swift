//
//  TimeTableDetailsViewCell.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class TimeTableViewCell: BaseTableViewCell {

    @IBOutlet weak var timeTableLabel: UILabel!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard  let item = item as? DetailsViewModelTimeTableItem else {
                return
            }
            
            timeTableLabel.text = ""
            timeTableLabel.textColor = UIColor.amberCardText
            let timeTitleString = "TIME_TABLE".localized
            let timeTableAttributedString = NSMutableAttributedString(string: timeTitleString + item.timeTable)
            timeTableAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans-Semibold", size: 17.0)!, range: NSRange(location: 0, length: timeTitleString.characters.count))
            timeTableLabel.attributedText = timeTableAttributedString
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
