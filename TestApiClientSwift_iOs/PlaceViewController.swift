import UIKit
import Alamofire
import AlamofireObjectMapper
import Agrume
import Kingfisher
import RealmSwift

class PlaceViewController: UIViewController {
    @IBOutlet weak var namePlaceLabel: UILabel!
    @IBOutlet weak var descriptionPlaceLabel: UILabel!
    @IBOutlet weak var categoryTypeImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var placeImageView: UIImageView!

    weak var viewModel: PlaceDetailsViewModel!

    var identifity = "PlaceViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // делаем прозрачным navBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

        UITabBar.appearance().tintColor = UIColor.clear
        UITabBar.appearance().backgroundColor = UIColor.clear
        //navigationController?.navigationBar.isHidden = false
        namePlaceLabel.text = viewModel.placeTitle
        descriptionPlaceLabel.text = viewModel.placeDescription
        categoryTypeImageView.kf.setImage(with: URL(string: BASE_URL_API + viewModel.categoryImgUrl))
        ratingControl.rating = viewModel.placeRate
        placeImageView.kf.setImage(with: URL(string: BASE_URL_API+viewModel.placePhotos[0]))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.tappedMe))
        placeImageView.addGestureRecognizer(tap)
        placeImageView.isUserInteractionEnabled = true

    }

    

    func tappedMe(){
        let urls = viewModel.placePhotos
        let agrume = Agrume(imageUrls: convertStringToUrlArray(urls: urls!))
        agrume.showFrom(self)
    }

    func convertStringToUrlArray(urls: [String]) -> [URL] {
        var urlArrays = [URL]()
        for item in urls{
            let url = URL(string: BASE_URL_API + item)
            urlArrays.append(url!)
        }
        return urlArrays
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : Navigation
    @IBOutlet weak var cancelBtn: UIBarButtonItem!

    @IBAction func cancelActionBtn(_ sender: UIBarButtonItem) {
        if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The PlaceViewController is not inside a navigation controller")
        }
    }
    

}
