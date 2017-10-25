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
        //signInButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //signInButton.isEnabled = true
        if textField == mailTextField {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                if ((floatingLabelTextField.text?.characters.count)! < 3) {
                    floatingLabelTextField.errorMessage = NSLocalizedString("LOGIN_ERROR", comment: "LOGIN_ERROR")
                } else {
                    floatingLabelTextField.errorMessage = ""
                }
            }
        }
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        switch textField.tag {
//        case 1:
//            if let text = textField.text {
//                if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
//                    if (text.characters.count < 3 || !text.contains("@")) {
//                        floatingLabelTextField.errorMessage = NSLocalizedString("INVALID_EMAIL", comment: "Invalid email")
//                    } else {
//                        floatingLabelTextField.errorMessage = ""
//                    }
//                }
//            }
//        default:
//            break
//        }
//        return true
//    }
}
