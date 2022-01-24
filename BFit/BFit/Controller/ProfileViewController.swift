//
//  ProfileViewController.swift
//  BFit
//
//  Created by mac on 19/01/2022.
//

import UIKit
import DropDown
import Firebase
import SCLAlertView

class ProfileViewController: UIViewController {

    @IBOutlet weak var allWorkoutBtn: UIButton!
    @IBOutlet weak var someWorkoutBtn: UIButton!
    @IBOutlet weak var allMealsBtn: UIButton!
    @IBOutlet weak var someMealsBtn: UIButton!
    
    @IBOutlet weak var nameTextView: UITextView!
    
    @IBOutlet weak var ageDropDownView: UIView!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var ageBtn: UIButton!
    
    @IBOutlet weak var weightDropDownView: UIView!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var weightBtn: UIButton!
    
    @IBOutlet weak var weightGoalDropDwonView: UIView!
    @IBOutlet weak var weightGoalLable: UILabel!
    @IBOutlet weak var weightGoalBtn: UIButton!
    
    @IBOutlet weak var hieghtDropDownView: UIView!
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var heightBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    
    let ageDropDown = DropDown()
    let weightDropDown = DropDown()
    let weightGoalDropDown = DropDown()
    let heightDropDown = DropDown()
    
    let ageDropDownValues = [
        "18 - 22 years", "23 - 27 years", "28 - 35 years", "36 - 42 years", "43 - 50 years", "51 - 60 years", "61 - 70 years", "+71 years"
    ]
    let weightDropDownValues = [
    "40 - 50 kg", "50 - 60 kg", "60 - 65 kg", "65 - 70 kg", "70 - 75 kg", "75 - 80 kg", "85 - 90 kg", "90 - 100 kg", "100 - 110 kg", "110 - 120 kg", "120 - 130 kg", "130 - 140 kg", "140 - 150 kg", "150 - 160 kg", "160 - 170 kg", "+170 kg"
    ]
    
    let weightGoalDropDownValues = [
        "50 kg", "60 kg", "70 kg", "75 kg", "80 kg", "85 kg", "90 kg", "95 kg", "100 kg", "105 kg", "110 kg", "120 kg", "130", "140"
    ]
    
    let heightDropDownValues = [
    "140 - 150 cm", "150 - 160 cm", "160 - 170 cm", "170 - 180 cm", "180 - 190 cm", "190 - 200 cm"
    ]
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        
        ageDropDownLayout()
        weightDropDownLayout()
        weightGoalDropDownLayout()
        heightDropDownLayout()

    }
    
    @IBAction func signoutAction(_ sender: Any) {
        
        
        do {
            try   Auth.auth().signOut()
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            present(vc, animated: true, completion: nil)
            
        } catch  {
            print(error.localizedDescription)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            present(vc, animated: true, completion: nil)
            
            
        }else{
            readTrainee()
        }
    }
    
    func ageDropDownLayout(){
        
        ageLable.text = "Choose age"
        ageDropDown.anchorView = ageDropDownView
        ageDropDown.dataSource = ageDropDownValues
        ageDropDown.bottomOffset = CGPoint(x: 0, y:(ageDropDown.anchorView?.plainView.bounds.height)!)
        ageDropDown.topOffset = CGPoint(x: 0, y:-(ageDropDown.anchorView?.plainView.bounds.height)!)
        ageDropDown.direction = .bottom
        ageDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.ageLable.text = ageDropDownValues[index]
        }
    }
    
    @IBAction func ageBtnClicked(_ sender: Any) {
        ageDropDown.show()
        
    }
    
    
    func weightDropDownLayout(){
        
        weightLable.text = "Choose weight"
        weightDropDown.anchorView = weightDropDownView
        weightDropDown.dataSource = weightDropDownValues
        weightDropDown.bottomOffset = CGPoint(x: 0, y:(weightDropDown.anchorView?.plainView.bounds.height)!)
        weightDropDown.topOffset = CGPoint(x: 0, y:-(weightDropDown.anchorView?.plainView.bounds.height)!)
        weightDropDown.direction = .bottom
        weightDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.weightLable.text = weightDropDownValues[index]
        }
    }
    
    @IBAction func weightBtnClicked(_ sender: Any) {
        weightDropDown.show()
    }
    
    
    
    func weightGoalDropDownLayout(){
        
        weightGoalLable.text = "Choose weight goal"
        weightGoalDropDown.anchorView = weightDropDownView
        weightGoalDropDown.dataSource = weightGoalDropDownValues
        weightGoalDropDown.bottomOffset = CGPoint(x: 0, y:(weightGoalDropDown.anchorView?.plainView.bounds.height)!)
        weightGoalDropDown.topOffset = CGPoint(x: 0, y:-(weightGoalDropDown.anchorView?.plainView.bounds.height)!)
        weightGoalDropDown.direction = .bottom
        weightGoalDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.weightGoalLable.text = weightGoalDropDownValues[index]
        }
    }
    
    
    @IBAction func weightGoalBtnClicked(_ sender: Any) {
        weightGoalDropDown.show()
    }
    
    
    func heightDropDownLayout(){
        
        heightLable.text = "Choose height"
        heightDropDown.anchorView = hieghtDropDownView
        heightDropDown.dataSource = heightDropDownValues
        heightDropDown.bottomOffset = CGPoint(x: 0, y:(heightDropDown.anchorView?.plainView.bounds.height)!)
        heightDropDown.topOffset = CGPoint(x: 0, y:-(heightDropDown.anchorView?.plainView.bounds.height)!)
        heightDropDown.direction = .bottom
        heightDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.heightLable.text = heightDropDownValues[index]
        }
    }
    
    @IBAction func heightBtnClicked(_ sender: Any) {
        heightDropDown.show()
    }
    
    

    @IBAction func saveBtnClicked(_ sender: Any) {
        if nameTextView.text!.isEmpty || ageLable.text == "Choose age" || weightLable.text == "Choose weight" || weightGoalLable.text == "Choose weight goal" || heightLable.text == "Choose height" {
            SCLAlertView().showError("hmmmm...", subTitle: "some fields are missing")
        }else {
        db.collection("Trainees")
            .document((Auth.auth().currentUser?.email)!)
            .setData([
                "name": nameTextView.text!,
                "age": ageLable.text!,
                "weight": weightLable.text!,
                "weight goal": weightGoalLable.text!,
                "height": heightLable.text!
                
            ], merge: true) { err in
                if let err = err {
                    print("Error when adding \(err.localizedDescription)")
                }else {
                    print("document added")
                }
            }

            SCLAlertView().showSuccess("your info successfully added!", subTitle: "your info successfully added!")
        }
    }
    
    func readTrainee() {
        db.collection("Trainees")
                    .whereField("TraineeID", isEqualTo: Auth.auth().currentUser!.uid)
                    .getDocuments() {
        
                        (querySnapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }else {
                            for document in querySnapshot!.documents {
                                let data = document.data()
                                self.nameTextView.text = data["name"] as? String ?? "Enter your name.."
                                self.ageLable.text = data["age"] as? String ?? "Choose age"
                                self.weightLable.text = data["weight"] as? String ?? "Choose weight"
                                self.weightGoalLable.text = data["weight goal"] as? String ?? "Choose weight goal"
                                self.heightLable.text = data["height"] as? String ?? "Choose height"

                            }
                        }
        
                    }
    }
}
