//
//  LoginViewController.swift
//  BFit
//
//  Created by mac on 05/01/2022.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var skipLoginBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewLayout()
        

    }
    
    func viewLayout() {
        
        
        //main image
        mainImage.contentMode = .scaleAspectFill
        mainImage.layer.cornerRadius = 40
        mainImage.clipsToBounds = true
        mainImage.image = UIImage(named: "Picture1")

        //email textfield
        emailTextfield.clipsToBounds = true
        emailTextfield.layer.cornerRadius = 15.0
        emailTextfield.layer.borderWidth = 2.0
        emailTextfield.layer.borderColor = UIColor.black.cgColor
        
        //password textfield
        passwordTextfield.clipsToBounds = true
        passwordTextfield.layer.cornerRadius = 15.0
        passwordTextfield.layer.borderWidth = 2.0
        passwordTextfield.layer.borderColor = UIColor.black.cgColor
        
        
        //Skip login button
        skipLoginBtn.clipsToBounds = true
        skipLoginBtn.layer.cornerRadius = 15.0
        skipLoginBtn.layer.borderWidth = 2.0
        skipLoginBtn.layer.borderColor = UIColor.black.cgColor
        
        //signUp button
        loginBtn.clipsToBounds = true
        loginBtn.layer.cornerRadius = 20
        
        // google signUp button
        googleLoginBtn.clipsToBounds = true
        googleLoginBtn.setImage(UIImage(named: "Picture2"), for: .normal)
        googleLoginBtn.layer.cornerRadius = 20
        googleLoginBtn.layer.borderWidth = 2.0
        googleLoginBtn.layer.borderColor = UIColor.black.cgColor
        
        //apple signUp button
        appleLoginBtn.clipsToBounds = true
        appleLoginBtn.setImage(UIImage(named: "Picture3"), for: .normal)
        appleLoginBtn.layer.cornerRadius = 20
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { authResult, error in
            if error == nil {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TraineeTabBarController") as! TraineeTabBarController
                self.present(nextVC, animated: true, completion: nil)
            }else {
                print(error?.localizedDescription)
                return
            }
        }

    }
    
    @IBAction func skipLoginBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TraineeTabBarController") as! TraineeTabBarController
        self.present(nextVC, animated: true, completion: nil)
    }
    
    

}

