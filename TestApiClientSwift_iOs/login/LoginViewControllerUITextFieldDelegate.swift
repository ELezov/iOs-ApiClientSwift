//
//  LoginViewControllerUITextFieldDelegate.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//
import SkyFloatingLabelTextField

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        signInButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        signInButton.isEnabled =  true
        if textField == mailTextField {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                if let count = floatingLabelTextField.text?.characters.count{
                    if count < 3, count > 0 {
                        floatingLabelTextField.errorMessage = "LOGIN_ERROR".localized
                    } else {
                        floatingLabelTextField.errorMessage = ""
                    }
                }
            }
        }
    }
}
