import UIKit

class PlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!

    @IBOutlet weak var placeDescriptionLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    
    weak var viewModel: PlaceTableCellViewModel! {
        didSet{
            self.categoryImg.kf.setImage(with: URL(string: BASE_URL_API+viewModel.categoryImgUrl!))
            self.categoryNameLabel.text = viewModel.categoryTitle
            placeNameLabel.text = viewModel.placeTitle
            placeDescriptionLabel.text = viewModel.placeDescription
            if viewModel.saleString == "0"{
                self.saleLabel.isHidden = false
            }
            else{
                self.saleLabel.text = viewModel.saleString
            }
            
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
