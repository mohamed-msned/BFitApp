//
//  CreatePackegeViewController.swift
//  BFit
//
//  Created by mac on 15/01/2022.
//

import UIKit
import DropDown
import Firebase
import SCLAlertView

class CreatePackegeViewController: UIViewController {

    @IBOutlet weak var packegeNameTextfield: UITextField!
    @IBOutlet weak var packegeDescriptionTextView: UITextView!
    @IBOutlet weak var packegePrice: UILabel!
    @IBOutlet weak var packegeDuration: UILabel!
    @IBOutlet weak var workoutTitleTextView: UITextView!
    @IBOutlet weak var workoutDescriptionTextView: UITextView!
    @IBOutlet weak var mealsTitleTextView: UITextView!
    @IBOutlet weak var mealsdescriptionTextView: UITextView!
    @IBOutlet weak var dayWorkoutTitleLable: UILabel!
    @IBOutlet weak var dayWorkoutDescriptionLable: UILabel!
    @IBOutlet weak var dayMealsTitleLable: UILabel!
    @IBOutlet weak var dayMealsDescriptionLable: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var viewForPriceDropDown: UIView!
    @IBOutlet weak var priceDropDownTitle: UILabel!
    @IBOutlet weak var priceDropDownBtn: UIButton!
    
    @IBOutlet weak var viewForDurationDropDown: UIView!
    @IBOutlet weak var durationDropDownTitle: UILabel!
    @IBOutlet weak var durationDropDownBtn: UIButton!
    
    let priceDropDown = DropDown()
    let durationDropDown = DropDown()
    let priceDropDownValues = [
        "200SR", "300SR", "400SR", "500SR", "600SR", "700SR", "800SR", "900SR", "1000SR", "1300SR", "1500SR", "2000SR", "3000SR"
    ]
    let durationDropDownValues = [
        "1 month", "2 month", "3 month", "6 month", "1 year", "forever"
    ]
    
    var dayCounter = 1
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceDropDownLayout()
        durationDropDownLayout()
        
        // scheduel lables
        dayWorkoutTitleLable.text = "day \(dayCounter) workout title"
        dayWorkoutDescriptionLable.text = "day \(dayCounter) workout"
        dayMealsTitleLable.text = "day \(dayCounter) meals title"
        dayMealsDescriptionLable.text = "day \(dayCounter) meals"
        
        // design
        viewLayout()
    }
    
    
    func viewLayout() {
        packegeNameTextfield.clipsToBounds = true
        packegeNameTextfield.layer.cornerRadius = 15.0
        packegeNameTextfield.layer.borderWidth = 2.0
        packegeNameTextfield.layer.borderColor = UIColor.black.cgColor
        
        packegeDescriptionTextView.clipsToBounds = true
        packegeDescriptionTextView.layer.cornerRadius = 15.0
        packegeDescriptionTextView.layer.borderWidth = 2.0
        packegeDescriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        workoutTitleTextView.clipsToBounds = true
        workoutTitleTextView.layer.cornerRadius = 15.0
        workoutTitleTextView.layer.borderWidth = 2.0
        workoutTitleTextView.layer.borderColor = UIColor.black.cgColor
        
        workoutDescriptionTextView.clipsToBounds = true
        workoutDescriptionTextView.layer.cornerRadius = 15.0
        workoutDescriptionTextView.layer.borderWidth = 2.0
        workoutDescriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        mealsTitleTextView.clipsToBounds = true
        mealsTitleTextView.layer.cornerRadius = 15.0
        mealsTitleTextView.layer.borderWidth = 2.0
        mealsTitleTextView.layer.borderColor = UIColor.black.cgColor
        
        mealsdescriptionTextView.clipsToBounds = true
        mealsdescriptionTextView.layer.cornerRadius = 15.0
        mealsdescriptionTextView.layer.borderWidth = 2.0
        mealsdescriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        viewForPriceDropDown.layer.cornerRadius = 15
        viewForPriceDropDown.layer.borderWidth = 2.0
        viewForPriceDropDown.layer.borderColor = UIColor.black.cgColor
        
        viewForDurationDropDown.layer.cornerRadius = 15
        viewForDurationDropDown.layer.borderWidth = 2.0
        viewForDurationDropDown.layer.borderColor = UIColor.black.cgColor
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 15
        
        
    }
    
    
    func priceDropDownLayout(){
        
        priceDropDownTitle.text = "Choose price"
        priceDropDown.anchorView = viewForPriceDropDown
        priceDropDown.dataSource = priceDropDownValues
        priceDropDown.bottomOffset = CGPoint(x: 0, y:(priceDropDown.anchorView?.plainView.bounds.height)!)
        priceDropDown.topOffset = CGPoint(x: 0, y:-(priceDropDown.anchorView?.plainView.bounds.height)!)
        priceDropDown.direction = .bottom
        priceDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.priceDropDownTitle.text = priceDropDownValues[index]
        }
    }

    @IBAction func dropDownBtnClicked(_ sender: Any) {
        priceDropDown.show()
    }
    
        
    func durationDropDownLayout() {
        
        durationDropDownTitle.text = "Choose duration"
        durationDropDown.anchorView = viewForDurationDropDown
        durationDropDown.dataSource = durationDropDownValues
        durationDropDown.bottomOffset = CGPoint(x: 0, y:(durationDropDown.anchorView?.plainView.bounds.height)!)
        durationDropDown.topOffset = CGPoint(x: 0, y:-(durationDropDown.anchorView?.plainView.bounds.height)!)
        durationDropDown.direction = .bottom
        durationDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.durationDropDownTitle.text = durationDropDownValues[index]
        }
    }
    @IBAction func durationDropDownClicked(_ sender: Any) {
        durationDropDown.show()
    }
    
    @IBAction func saveData(_ sender: Any) {
        if packegeNameTextfield.text!.isEmpty || packegeDescriptionTextView.text.isEmpty || packegePrice.text == "Choose price" || packegeDuration.text == "Choose duration" || workoutTitleTextView.text!.isEmpty || workoutDescriptionTextView.text.isEmpty || mealsTitleTextView.text.isEmpty || mealsdescriptionTextView.text.isEmpty {
            SCLAlertView().showError("hmmmm...", subTitle: "some fields are missing")
        }else {
        if dayCounter < 8 {
            // take data
        db.collection("Packeges")
            .document(packegeNameTextfield.text!)
            .setData([
                "name": packegeNameTextfield.text!,
                "description": packegeDescriptionTextView.text!,
                "price": packegePrice.text!,
                "duration": packegeDuration.text!,
                "day \(dayCounter) workout title": workoutTitleTextView.text!,
                "day \(dayCounter) workout description": workoutDescriptionTextView.text!,
                "day \(dayCounter) meals title": mealsTitleTextView.text!,
                "day \(dayCounter) meals description": mealsdescriptionTextView.text!
            ],merge: true) { err in
                if let err = err {
                    print("Error when adding \(err.localizedDescription)")
                }else {
                    print("document added")
                }
            }

            if dayCounter != 7 {
            // alert to fill other day
            SCLAlertView().showSuccess("day \(dayCounter) added successfully", subTitle: "you can add day \(dayCounter + 1) now!")
            
            // change lables day by adding one to dayCounter
            dayCounter += 1
            }else {
                SCLAlertView().showSuccess("your packege has been completed", subTitle: "you can add new packege!")

                packegeNameTextfield.text = ""
                packegeDescriptionTextView.text = ""
                priceDropDownTitle.text = "Choose price"
                durationDropDownTitle.text = "Choose duration"

            }
            // set textfields to empty
            workoutTitleTextView.text = ""
            workoutDescriptionTextView.text = ""
            mealsTitleTextView.text = ""
            mealsdescriptionTextView.text = ""
            
            //change placeholders
            dayWorkoutTitleLable.text = "day \(dayCounter) workout title"
            dayWorkoutDescriptionLable.text = "day \(dayCounter) workout"
            dayMealsTitleLable.text = "day \(dayCounter) meals title"
            dayMealsDescriptionLable.text = "day \(dayCounter) meals"
        }

        }
    }
    
    
    
    
    
}



