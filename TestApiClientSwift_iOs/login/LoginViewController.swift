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
        signInButton.backgroundColor = UIColor.amberCardBlue
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
        if passwordTextField.text?.characters.count != 0,
            (mailTextField.text?.characters.count)! > 3 {
            signInButton.isEnabled = false
            LoadingIndicatorView.show()
            let networkManager = NetworkManager()
            networkManager.logIn(name: mailTextField.text!, password: passwordTextField.text!) { [weak self] flag, error in
                LoadingIndicatorView.hide()
                if flag == true {
                    //Сохраняем токен
                    let userDafaults = UserDefaults.standard
                    userDafaults.set(error, forKey: userToken)
                    userDafaults.synchronize()
                    //анимируемый переход на следущий экран
                    self?.signInButton.isEnabled = true
                    self?.pushAnimation()
                } else {
                    self?.showError(error)
                    self?.signInButton.isEnabled = true
                }
            }
        }
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "CONNECTION_ERROR".localized, message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "CANCEL".localized , style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetTextFields() {
        mailTextField.text = ""
        mailTextField.placeholder = "LOGIN_ENTER".localized
        mailTextField.selectedTitle = "LOGIN".localized
        passwordTextField.text = ""
        passwordTextField.placeholder = "PASSWORD_ENTER".localized
        passwordTextField.selectedTitle = "PASSWORD".localized
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
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }}
