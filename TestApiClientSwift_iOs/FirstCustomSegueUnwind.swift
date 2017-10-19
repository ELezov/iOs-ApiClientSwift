//
//  FirstCustomSegueUnwind.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 19.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class FirstCustomSegueUnwind: UIStoryboardSegue {
    
    override func perform() {
        var secondVCView = self.source.view as UIView!
        var firstVCView = self.destination.view as UIView!
        
        let screenHeight = UIScreen.main.bounds.size.height
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(firstVCView!, aboveSubview: secondVCView!)
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: 0.0, dy: screenHeight))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: 0.0, dy: screenHeight))!
        }) { (Finished) -> Void in
            self.source.dismiss(animated: false, completion: nil)
        
        }
    }
    
    
    

}
