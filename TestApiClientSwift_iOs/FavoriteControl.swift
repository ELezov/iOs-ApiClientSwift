//
//  FavoriteControl.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 12.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

@IBDesignable
class FavoriteControl: UIStackView {

    private var ratingButtons = [UIButton]()
    
    var isFavorite: Bool = false {
        didSet{
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
    @IBInspectable var heartSize: CGSize = CGSize(width: 20.0, height: 20.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var heartCount: Int = 1{
        didSet{
            setupButtons()
        }
    }
    
    //Mark : Action
    
    func ratingButtonTapped(button: UIButton){
        if isFavorite == false{
            isFavorite = true
        } else {
            isFavorite = false
        }
        
        print(isFavorite)
    }
    
    
    //Mark : Private Methods
    
    private func setupButtons(){
        
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of:self))
        
        let filledFavorite = UIImage(named: "filledFavorite", in: bundle, compatibleWith : self.traitCollection)
        
        let emptyFavorite = UIImage(named: "emptyFavorite", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<heartCount {
            let button = UIButton()
            
            
            
            button.setImage(emptyFavorite, for: .normal)
            button.setImage(filledFavorite, for: [.selected, .highlighted])
            button.setImage(filledFavorite, for: .selected)
            button.setImage(filledFavorite, for: .highlighted)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: heartSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: heartSize.width).isActive = true
            
            button.addTarget(self, action: #selector(FavoriteControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            
            if isFavorite == false {
                button.isSelected = false
            }
            else{
                button.isSelected = true
            }
            
        }
    }
    
}
