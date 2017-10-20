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
        leftPoint.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        rightPoint.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        mailTextField.text = ""
        passwordTextField.text = ""
        mailTextField.errorMessage = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token: String = UserDefaults.standard.object(forKey: "userToken") as! String? {
            //let id = "ShowList"
            // self.performSegue(withIdentifier: id, sender: self)
            pushAnimation()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        if let id = identifier {
            if id == "idFirstSegueUnwind"{
                let unwindSegue = FirstCustomSegueUnwind(identifier: id, source: fromViewController, destination: toViewController, performHandler: {() -> Void in
                })
                return unwindSegue
            }
        }
        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)
    }
    
    @IBAction func returnFromSegueActionsLogOut(sender: UIStoryboardSegue){
        
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
        if textField == passwordTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        SignInButton.isEnabled = true
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
        return true
    }
    
    
    // MARK: Action
    //производим авторизацию
    @IBAction func logIn(_ sender: UIButton) {
        let networkManager = NetworkManager()
        networkManager.logIn(name: mailTextField.text!, password: passwordTextField.text!){ flag, error in
            if flag == true {
                //Сохраняем токен
                let userDafaults = UserDefaults.standard
                userDafaults.set(error, forKey: "userToken")
                userDafaults.synchronize()
                //анимируемый переход на следущий экран
                self.pushAnimation()
                //let id = "ShowList"
                //self.performSegue(withIdentifier: id, sender: self)
            } else {
                //показываем тост ошибки
                self.view.makeToast(error, duration: 10.0, position: .bottom)
            }
            
        }
    }
    
    func pushAnimation(){
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "PlaceTableViewController")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCAGravityBottom
        self.navigationController?.view.layer.add(transition,forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
