//
//  TrainerSignUpViewController.swift
//  BFit
//
//  Created by mac on 05/01/2022.
//

import UIKit

class TrainerSignUpViewController: UIViewController {

    @IBOutlet weak var PersonalImage: UIImageView!
    
    @IBOutlet weak var editPersonalImgBtn: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var fullNametextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var passwordVerfTextfield: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLayout()
       
    }
    

    func viewLayout() {
        
        //personal image
        PersonalImage.image = UIImage(named: "Picture4")
        
        //email textfield
        emailTextfield.clipsToBounds = true
        emailTextfield.layer.cornerRadius = 15.0
        emailTextfield.layer.borderWidth = 2.0
        emailTextfield.layer.borderColor = UIColor.black.cgColor
        
        //full name textfield
        fullNametextfield.clipsToBounds = true
        fullNametextfield.layer.cornerRadius = 15.0
        fullNametextfield.layer.borderWidth = 2.0
        fullNametextfield.layer.borderColor = UIColor.black.cgColor
        
        //phone number textfield
        phoneNumberTextfield.clipsToBounds = true
        phoneNumberTextfield.layer.cornerRadius = 15.0
        phoneNumberTextfield.layer.borderWidth = 2.0
        phoneNumberTextfield.layer.borderColor = UIColor.black.cgColor
        
        
        //password textfield
        passwordTextfield.clipsToBounds = true
        passwordTextfield.layer.cornerRadius = 15.0
        passwordTextfield.layer.borderWidth = 2.0
        passwordTextfield.layer.borderColor = UIColor.black.cgColor

        //password verfication textfield
        passwordVerfTextfield.clipsToBounds = true
        passwordVerfTextfield.layer.cornerRadius = 15.0
        passwordVerfTextfield.layer.borderWidth = 2.0
        passwordVerfTextfield.layer.borderColor = UIColor.black.cgColor
        
        //sign up button
        signUpBtn.clipsToBounds = true
        signUpBtn.layer.cornerRadius = 20
    }
   

}
