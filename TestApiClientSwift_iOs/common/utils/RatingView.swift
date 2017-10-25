import UIKit

@IBDesignable
class RatingView: UIStackView {

    private var ratingButtons = [UIButton]()
    var rating: Int = 5 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //Mark : Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //Mark : Properties
    @IBInspectable var starSize: CGSize = CGSize(width: 16.0, height: 16.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    //Mark : Action
    
//    func ratingButtonTapped(button: UIButton){
//        guard let index = ratingButtons.index(of: button) else {
//            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
//        }
//        
//        let selectedRating = index + 1
//        
//        if selectedRating == rating {
//            rating = 0
//        } else {
//            rating = selectedRating
//        }
//    }
    
    
    //Mark : Private Methods
    private func setupButtons() {
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        let bundle = Bundle(for: type(of:self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith : self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        for index in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: [.selected, .highlighted])
            button.setImage(filledStar, for: .selected)
            button.setImage(filledStar, for: .highlighted)
            button.accessibilityLabel = "Set \(index + 1) star rating"
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
            
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else{
                hintString = nil
            }
            
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
