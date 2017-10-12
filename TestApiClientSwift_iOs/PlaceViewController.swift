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
    @IBOutlet weak var timeTableText: UILabel!
    @IBOutlet weak var costText: UILabel!
    @IBOutlet weak var phoneText: UILabel!
    @IBOutlet weak var phoneView: UIView!

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
        
        let timeTableAttributedString = NSMutableAttributedString(string: "Режим работы: " + viewModel.timeTable)
        timeTableAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans-Semibold", size: 17.0)!, range: NSRange(location: 0, length: 12))
        timeTableText.attributedText = timeTableAttributedString
        
        let costAttributedText = NSMutableAttributedString(string: "Стоимость посещения: "  + viewModel.costText)
        costAttributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans-Semibold", size: 17.0)!, range: NSRange(location: 0, length: 19))
        
        costText.attributedText = costAttributedText
        phoneText.text = viewModel.phoneText
        //action for phone call
        let tapCallPhone = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.makeCallPhone))
        phoneView.addGestureRecognizer(tapCallPhone)
        phoneView.isUserInteractionEnabled = true

        //action for gallery
        let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.openGalleryAction))
        placeImageView.addGestureRecognizer(tap)
        placeImageView.isUserInteractionEnabled = true

    }

    

    func openGalleryAction(){
        let urls = viewModel.placePhotos
        let agrume = Agrume(imageUrls: convertStringToUrlArray(urls: urls!))
        agrume.showFrom(self)
    }
    
    func makeCallPhone(){
        if let url = URL(string: "tel://\(viewModel.phoneText)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else {
                UIApplication.shared.openURL(url)
            }
            print("1",url.description)
        }
        print(viewModel.phoneText)
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
