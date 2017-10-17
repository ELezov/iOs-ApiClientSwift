import UIKit

class PlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var saleBackgroundImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!

    @IBOutlet weak var placeDescriptionLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    
    weak var viewModel: PlaceTableCellViewModel! {
        didSet{
            initView()
            self.categoryImg.kf.setImage(with: URL(string: BASE_URL_API+viewModel.categoryImgUrl!))
            self.categoryNameLabel.text = viewModel.categoryTitle
            self.placeNameLabel.text = viewModel.placeTitle
            self.placeDescriptionLabel.text = viewModel.placeDescription
            if viewModel.saleString == "0" {
                self.saleLabel.isHidden = true
                self.saleBackgroundImage.isHidden = true
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
        self.saleBackgroundImage.isHidden = false
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
