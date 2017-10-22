//
//  FirstCustomSegue.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 19.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class FirstCustomSegue: UIStoryboardSegue {
    
    override func perform() {
        var firstVCView = self.source.view as UIView!
        var secondVCView = self.destination.view as UIView!
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeigt = UIScreen.main.bounds.size.height
        
        secondVCView?.frame = CGRect(x: 0.0, y: screenHeigt, width: screenWidth, height: screenHeigt)
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        UIView.animate(withDuration: 0.4, animations:{ () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeigt))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeigt))!
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController, animated: false, completion: nil)
        }
    }

}
