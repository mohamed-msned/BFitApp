//
//  LoginViewController.swift
//  BFit
//
//  Created by mac on 05/01/2022.
//

import UIKit
import Firebase
import SCLAlertView

class LoginViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var skipLoginBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    let db = Firestore.firestore()
    var typeOfTrainer = ""
    var typeOfTrainee = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

        viewLayout()
        self.hideKeyboardWhenTappedAround()
        

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
                self.getTrainerInfo(email: self.emailTextfield.text!)
                self.getTraineeInfo(email: self.emailTextfield.text!)
                
            }else {
                
                SCLAlertView().showError("Error", subTitle: error!.localizedDescription)
            }
        }
        
        
        

    }
    

    
    
    @IBAction func skipLoginBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TraineeTabBarController") as! TraineeTabBarController
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func getTrainerInfo(email : String) {
        db.collection("Personal Trainers")
            .whereField("Email", isEqualTo: email)
            .getDocuments() {
                
                (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    
                    if let count = querySnapshot?.documents.count {

                        if count > 0{
                            for document in querySnapshot!.documents {
                                
                                
                                let data = document.data()
                                
                                if data["Type"] as! String == "Trainer" && email == data["Email"] as! String   {
                                    print( "🤨I am trainer")
                                    self.typeOfTrainer = "Trainer"
                                    
                                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TrainerTabBarController") as! TrainerTabBarController
                                               self.present(nextVC, animated: true, completion: nil)
                                    
                                }
                                
                            }
                        }
                       
                        
                    }
                  
                }
                
            }
    }
    func getTraineeInfo(email : String){
        db.collection("Trainees")
            .whereField("Email", isEqualTo: email)
            .getDocuments() {
                
                (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    
                    if let count = querySnapshot?.documents.count {
                    
                    
                        if count > 0{
                            
                            for document in querySnapshot!.documents {
                                
                                let data = document.data()
                                
                                if data["Type"] as! String == "Trainee" && email == data["Email"] as! String   {
                                    print("I am trainee")
                                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TraineeTabBarController") as! TraineeTabBarController
                                    self.present(nextVC, animated: true, completion: nil)
                                    self.typeOfTrainer = "Trainee"
                                    
                                }
                            }
                            
                        }
                    
                    }
                    
                 
                }
                
            }
    }
    
    @IBAction func moveToSignUp(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpTraineeViewController") as! SignUpTraineeViewController
        self.present(nextVC, animated: true, completion: nil)

    }
    

}

