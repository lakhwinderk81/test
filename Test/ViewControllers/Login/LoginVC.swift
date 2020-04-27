//
//  LoginVC.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginVC: UIViewController {

    //Outlets
    @IBOutlet var imgSlantCut: UIImageView?
    @IBOutlet var tfEmail: UITextField?
    @IBOutlet var tfPassword: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignInAction(sender: UIButton){
        tfEmail?.resignFirstResponder()
        tfPassword?.resignFirstResponder()
        //        loginBtn.isUserInteractionEnabled = false
        guard let email = tfEmail?.text, !email.isEmpty, email.isValidEmail() else {
            self.view.makeToast("Invalid Email")
            return
        }
        guard let password = tfPassword?.text, !password.isEmpty, password.count >= 5 else {
            self.view.makeToast("Invalid Password")
            return
        }
        if let accounts = UserDefaults.standard.array(forKey: "Accounts") as? [[String:Any]]{
            for account in accounts {
                if (account["email"] as! String) == email{
                    if (account["password"] as! String) == password{
                        let productListVc = self.storyboard?.instantiateViewController(identifier: "ProductListVC") as! ProductListVC
                        self.navigationController?.pushViewController(productListVc, animated: true)
                        break
                    }else{
                        self.view.makeToast("Password Mismatched")
                    }
                }else{
                    self.view.makeToast("Email not registered")
                }
            }
        }else{
            self.view.makeToast("Unable to access account")
        }
    }
}

// Preparing the UI
extension LoginVC{
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        imgSlantCut?.getSlantCut()
        tfEmail?.setLeftImage(image: UIImage.init(named: "email")!)
        tfPassword?.setLeftImage(image: UIImage.init(named: "lock")!)
    }
}
