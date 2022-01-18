//
//  TrainerSignUpViewController.swift
//  BFit
//
//  Created by mac on 05/01/2022.
//

import UIKit
import Firebase
import DropDown

class TrainerSignUpViewController: UIViewController {

    @IBOutlet weak var PersonalImage: UIImageView!
    
    @IBOutlet weak var editPersonalImgBtn: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var fullNametextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var passwordVerfTextfield: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    
    @IBOutlet weak var viewForGenderDropDown: UIView!
    @IBOutlet weak var genderButtonDropDown: UIButton!
    @IBOutlet weak var genderDropDownLable: UILabel!
    
    let genderDropDown = DropDown()
    let genderDropDownValues = ["Male", "Female"]
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLayout()
        genderDropDownLayout()
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
        
        //birth day textfields
        dayTextField.clipsToBounds = true
        dayTextField.layer.cornerRadius = 15.0
        dayTextField.layer.borderWidth = 2.0
        dayTextField.layer.borderColor = UIColor.black.cgColor
        
        monthTextfield.clipsToBounds = true
        monthTextfield.layer.cornerRadius = 15.0
        monthTextfield.layer.borderWidth = 2.0
        monthTextfield.layer.borderColor = UIColor.black.cgColor
        
        yearTextfield.clipsToBounds = true
        yearTextfield.layer.cornerRadius = 15.0
        yearTextfield.layer.borderWidth = 2.0
        yearTextfield.layer.borderColor = UIColor.black.cgColor
        
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
        
        // drop down view
        viewForGenderDropDown.clipsToBounds = true
        viewForGenderDropDown.layer.cornerRadius = 15
        viewForGenderDropDown.layer.borderWidth = 2.0
        viewForGenderDropDown.layer.borderColor = UIColor.black.cgColor
    }
   
    @IBAction func signUpClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { authResult, error in
            if error == nil {
                print("signed up succesfullly!")
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(nextVC, animated: true, completion: nil)
                
                self.db.collection("Personal Trainers")
                    .document(self.emailTextfield.text!)
                    .setData([
                        "Email": self.emailTextfield.text!,
                        "Full name": self.fullNametextfield.text!,
                        "Phone number": self.phoneNumberTextfield.text!,
                        "Description": "",
                        "Day": self.dayTextField.text!,
                        "Month": self.monthTextfield.text!,
                        "Year": self.yearTextfield.text!,
                        "Gender": self.genderDropDownLable.text!,
                        "Type": "Trainer",
                        "TrainerID": Auth.auth().currentUser!.uid
                    ]) { err in
                        if let err = err {
                            print("Error when adding \(err.localizedDescription)")
                        }else {
                            print("document added")
                        }
                    }
            }else {
                print(error?.localizedDescription)
            }
        }
        
        
        
        
    }
    
    func genderDropDownLayout(){
        
        genderDropDownLable.text = "Gender"
        genderDropDown.anchorView = viewForGenderDropDown
        genderDropDown.dataSource = genderDropDownValues
        genderDropDown.bottomOffset = CGPoint(x: 0, y:(genderDropDown.anchorView?.plainView.bounds.height)!)
        genderDropDown.topOffset = CGPoint(x: 0, y:-(genderDropDown.anchorView?.plainView.bounds.height)!)
        genderDropDown.direction = .bottom
        genderDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.genderDropDownLable.text = genderDropDownValues[index]
        }
    }
    
    @IBAction func genderDropDownBtnClicked(_ sender: Any) {
        genderDropDown.show()

    }
    @IBAction func moveToLogin(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(nextVC, animated: true, completion: nil)
    }
    @IBAction func moveToTraineeSignUp(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpTraineeViewController") as! SignUpTraineeViewController
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}
