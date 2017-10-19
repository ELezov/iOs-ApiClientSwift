//
//  LoginViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leftPoint: UIView!
    @IBOutlet weak var rightPoint: UIView!
    
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBOutlet weak var mailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailTextField.delegate = self
        mailTextField.errorColor = UIColor.red
        passwordTextField.delegate = self

        // Do any additional setup after loading the view.
        leftPoint.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        rightPoint.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SignInButton.isEnabled = false
        print("false")
        if textField == passwordTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        SignInButton.isEnabled = true
        print("true")
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 1:
            if let text = textField.text{
                if let floatingLabelTextField = textField as? SkyFloatingLabelTextField{
                    if (text.characters.count < 3 || !text.contains("@")) {
                        floatingLabelTextField.errorMessage = "Invalid email"
                    } else{
                        floatingLabelTextField.errorMessage = ""
                    }
                }
            }
        default:
            break
        }
        print(textField.tag)
        return true
    }
    
    
    // MARK: Action

    @IBAction func logIn(_ sender: UIButton) {
        let networkManager = NetworkManager()
        networkManager.logIn(name: mailTextField.text!, password: passwordTextField.text!){ flag, error in
            if flag == true{
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let scrollingNavController = mainStoryBoard.instantiateViewController(withIdentifier: "ScrollingNavigationController")
                //let navController: UINavigationController = placeTableViewController.navigationController!
                self.present(scrollingNavController, animated: true, completion: nil)
            } else{
                self.view.makeToast(error, duration: 10.0, position: .bottom)
            }
            
        }
    }
}
