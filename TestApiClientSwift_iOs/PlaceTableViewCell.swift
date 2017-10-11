import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeDescriptionLabel: UILabel!
    
    weak var viewModel: PlaceTableCellViewModel! {
        didSet{
            self.categoryImageView.kf.setImage(with: URL(string: BASE_URL_API+viewModel.categoryImgUrl))
            self.categoryNameLabel.text = viewModel.categoryTitle
            self.placeNameLabel.text = viewModel.placeTitle
            self.placeDescriptionLabel.text = viewModel.placeDescription
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
