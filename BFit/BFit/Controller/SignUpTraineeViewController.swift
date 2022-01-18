//
//  ViewController.swift
//  BFit
//
//  Created by mac on 04/01/2022.
//

import UIKit
import Firebase

class SignUpTraineeViewController: UIViewController {

    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var passwordVerfTextfield: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var googleSignUpBtn: UIButton!
    @IBOutlet weak var appleSignUpBtn: UIButton!
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLayout()
        

    }
    
    
    
    func viewLayout() {
        
        //main image
        signUpImage.contentMode = .scaleAspectFill
        signUpImage.layer.cornerRadius = 40
        signUpImage.clipsToBounds = true
        signUpImage.image = UIImage(named: "Picture1")
        
        //email textfield
        emailTextfield.clipsToBounds = true
        emailTextfield.layer.cornerRadius = 15.0
        emailTextfield.layer.borderWidth = 2.0
        emailTextfield.layer.borderColor = UIColor.black.cgColor
        
        //password textfield
        PasswordTextfield.clipsToBounds = true
        PasswordTextfield.layer.cornerRadius = 15.0
        PasswordTextfield.layer.borderWidth = 2.0
        PasswordTextfield.layer.borderColor = UIColor.black.cgColor
        
        //password verification textfield
        passwordVerfTextfield.clipsToBounds = true
        passwordVerfTextfield.layer.cornerRadius = 15.0
        passwordVerfTextfield.layer.borderWidth = 2.0
        passwordVerfTextfield.layer.borderColor = UIColor.black.cgColor
        
        //signUp button
        signUpBtn.clipsToBounds = true
        signUpBtn.layer.cornerRadius = 20
        
        // google signUp button
        googleSignUpBtn.clipsToBounds = true
        googleSignUpBtn.setImage(UIImage(named: "Picture2"), for: .normal)
        googleSignUpBtn.layer.cornerRadius = 20
        googleSignUpBtn.layer.borderWidth = 2.0
        googleSignUpBtn.layer.borderColor = UIColor.black.cgColor
        
        //apple signUp button
        appleSignUpBtn.clipsToBounds = true
        appleSignUpBtn.setImage(UIImage(named: "Picture3"), for: .normal)
        appleSignUpBtn.layer.cornerRadius = 20
        
    }
    
//    func setData() {
//        db.collection("Users")
//                .document("order1").setData(
//                    [
//                        "orderId" : "73246891",
//                        "Date" : "2021-12-9",
//                        "address" : "Riyadh"
//
//                    ])
//            {(error) in
//                if error == nil {
//                    print("Added Succ..")
//                }else {
//                    print(error?.localizedDescription)
//                }
//            }
//    }
    
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: PasswordTextfield.text!) { authResult, error in
            if error == nil {
                print("signed up succesfullly!")
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.present(nextVC, animated: true, completion: nil)
                
                self.db.collection("Trainees")
                    .document(self.emailTextfield.text!)
                    .setData([
                        "Email": self.emailTextfield.text!,
                        "Type": "Trainee",
                        "TraineeID": Auth.auth().currentUser!.uid
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
    
    @IBAction func moveToLoginBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "moveLogin", sender: nil)
    }
    
    
    
    


}

