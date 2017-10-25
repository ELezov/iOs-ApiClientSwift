//
//  LoginViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leftPoint: UIView!
    @IBOutlet weak var rightPoint: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var mailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        mailTextField.delegate = self
        mailTextField.errorColor = UIColor.red
        passwordTextField.delegate = self
        leftPoint.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        rightPoint.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if let _: String = UserDefaults.standard.string(forKey: userToken) {
            pushAnimation()
        }
        resetTextFields()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Action
    //производим авторизацию
    @IBAction func logIn(_ sender: UIButton) {
        let networkManager = NetworkManager()
        networkManager.logIn(name: mailTextField.text!, password: passwordTextField.text!) { [weak self] flag, error in
            if flag == true {
                //Сохраняем токен
                let userDafaults = UserDefaults.standard
                userDafaults.set(error, forKey: userToken)
                userDafaults.synchronize()
                //анимируемый переход на следущий экран
                self?.pushAnimation()
            } else {
                self?.showError(error)
            }
        }
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: NSLocalizedString("CONNECTION_ERROR", comment: "Проблемы с подключение"), message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Cancel"), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetTextFields() {
        mailTextField.text = ""
        mailTextField.placeholder = NSLocalizedString("LOGIN_ENTER", comment: "Enter login")
        mailTextField.selectedTitle = NSLocalizedString("LOGIN", comment: "Login")
        passwordTextField.text = ""
        passwordTextField.placeholder = NSLocalizedString("PASSWORD_ENTER", comment: "Enter password")
        passwordTextField.selectedTitle = NSLocalizedString("PASSWORD", comment: "Password")
        mailTextField.errorMessage = ""
    }
    
    //Анимированный пееход на другой VC
    func pushAnimation() {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: nameMainStoryBoard, bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: PlaceListViewController.id)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCAGravityBottom
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func keyboardWillShow(notification: Notification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        let viewHeight = self.view.bounds.size.height
        if ((keyboardHeight > (viewHeight - passwordTextField.frame.maxY)) ||
            (keyboardHeight > (viewHeight - mailTextField.frame.maxY))){
            scrollView.setContentOffset(CGPoint(x: 0, y: keyboardHeight), animated: true)
        }
        // do whatever you want with this keyboard height
    }
    
    func keyboardWillHide(notification: Notification) {
        // keyboard is dismissed/hidden from the screen
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }}
