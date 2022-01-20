//
//  scheduelViewController.swift
//  BFit
//
//  Created by mac on 20/01/2022.
//

import UIKit
import Firebase
import SCLAlertView
class scheduelViewController: UIViewController {

    
    @IBOutlet weak var dayOneTrainingLable: UILabel!
    @IBOutlet weak var dayTwoTrainingLable: UILabel!
    @IBOutlet weak var dayThreeTrainingLable: UILabel!
    @IBOutlet weak var dayFourTrainingLable: UILabel!
    @IBOutlet weak var dayFiveTrainingLable: UILabel!
    @IBOutlet weak var daySixTrainingLable: UILabel!
    @IBOutlet weak var daySevenTrainingLable: UILabel!
    
    @IBOutlet weak var dayOneMealsLable: UILabel!
    @IBOutlet weak var dayTwoMealsLable: UILabel!
    @IBOutlet weak var dayThreeMealsLable: UILabel!
    @IBOutlet weak var dayFourMealsLable: UILabel!
    @IBOutlet weak var dayFiveMealsLable: UILabel!
    @IBOutlet weak var daySixMealsLable: UILabel!
    @IBOutlet weak var daySevenMealsLable: UILabel!
    
    var package: Packege?
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser == nil {
            
            let customeAlert = SCLAlertView()

            customeAlert.addButton("Sign in", backgroundColor: UIColor(named: "fixedOrange"), textColor: .gray) {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

                self.present(vc, animated: true, completion: nil)
              
            }
            
            customeAlert.showNotice("Please sign in", subTitle: "you need to sign in to see your pachages")
         
            
            
            
            
            
        }else{
            readTrainee()
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
                               
                                let packageID = data["packageID"] as! String
                                
                                self.readPackage(packageID: packageID)

                            }
                        }
        
                    }
    }
    
    func readPackage(packageID : String) {
        
        
        db.collection("Packeges").whereField("packageID", isEqualTo: packageID).getDocuments { querySnapshot, error in
            
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                for document in querySnapshot!.documents{
                    let data = document.data()

                    self.package =  Packege(packegeDescription: data["description"] as? String ?? "_", name: data["name"] as? String ?? "_", duration: data["duration"] as? String ?? "_", price: data["price"] as? String ?? "_", trainerID: data["userID"] as? String ?? "_", packegeID: data["packageID"] as? String ?? "_", day1WorkoutTitle: data["day 1 workout title"] as? String ?? "_", day1Workout: data["day 1 workout description"] as? String ?? "_", day1MealsTitle: data["day 1 meals title"] as? String ?? "_", day1MeaksDescription: data["day 1 meals description"] as? String ?? "_", day2WorkoutTitle: data["day 2 workout title"] as? String ?? "_", day2Workout: data["day 2 workout description"] as? String ?? "_", day2MealsTitle: data["day 2 meals title"] as? String ?? "_", day2MeaksDescription: data["day 2 meals description"] as? String ?? "_", day3WorkoutTitle: data["day 3 workout title"] as? String ?? "_", day3Workout: data["day 3 workout description"] as? String ?? "_", day3MealsTitle: data["day 3 meals title"] as? String ?? "_", day3MeaksDescription: data["day 3 meals description"] as? String ?? "_", day4WorkoutTitle: data["day 4 workout title"] as? String ?? "_", day4Workout: data["day 4 workout description"] as? String ?? "_", day4MealsTitle: data["day 4 meals title"] as? String ?? "_", day4MeaksDescription: data["day 4 meals description"] as? String ?? "_", day5WorkoutTitle: data["day 5 workout title"] as? String ?? "_", day5Workout: data["day 5 workout description"] as? String ?? "_", day5MealsTitle: data["day 5 meals title"] as? String ?? "_", day5MeaksDescription: data["day 5 meals description"] as? String ?? "_", day6WorkoutTitle: data["day 6 workout title"] as? String ?? "_", day6Workout: data["day 6 workout description"] as? String ?? "_", day6MealsTitle: data["day 6 meals title"] as? String ?? "_", day6MeaksDescription: data["day 6 meals description"] as? String ?? "_", day7WorkoutTitle: data["day 7 workout title"] as? String ?? "_", day7Workout: data["day 7 workout description"] as? String ?? "_", day7MealsTitle: data["day 7 meals title"] as? String ?? "_", day7MeaksDescription: data["day 7 meals description"] as? String ?? "_")

                    self.updateUI()
                    
                }
              
            }
            
            
        }
    }
    
    
    
    func updateUI(){
        
        
        dayOneTrainingLable.text = package?.day1WorkoutTitle
        dayTwoTrainingLable.text = package?.day2WorkoutTitle
        dayThreeTrainingLable.text = package?.day3WorkoutTitle
        dayFourTrainingLable.text = package?.day4WorkoutTitle
        dayFiveTrainingLable.text = package?.day5WorkoutTitle
        daySixTrainingLable.text = package?.day6WorkoutTitle
        daySevenTrainingLable.text = package?.day7WorkoutTitle
        
        dayOneMealsLable.text = package?.day1MealsTitle
        dayTwoMealsLable.text = package?.day2MealsTitle
        dayThreeMealsLable.text = package?.day3MealsTitle
        dayFourMealsLable.text = package?.day4MealsTitle
        dayFiveMealsLable.text = package?.day5MealsTitle
        daySixMealsLable.text = package?.day6MealsTitle
        daySevenMealsLable.text = package?.day7MealsTitle

        
        
        
        
    }
    
    
    func dynamicWorkButtonAction(title :String , desc  :String){
        
        let customAlert = SCLAlertView()
        
        if package == nil {
            
            customAlert.showWait("wait", subTitle: "waaaait")
            
        }else{
            
            
            customAlert.showInfo(title, subTitle: desc)
            
            
        }
        
    }
    
    @IBAction func workoutDayOneBtn(_ sender: Any) {
   
        
        dynamicWorkButtonAction(title: package?.day1WorkoutTitle ?? "", desc: package?.day1Workout ?? "")
    }
    
    @IBAction func workoutDayTwoBtn(_ sender: Any) {
        
        dynamicWorkButtonAction(title: package?.day2WorkoutTitle ?? "", desc: package?.day2Workout ?? "")
        
    }
    @IBAction func workoutDayThreeBtn(_ sender: Any) {
        
        dynamicWorkButtonAction(title: package?.day3WorkoutTitle ?? "", desc: package?.day3Workout ?? "")
    }
    
    @IBAction func workoutDayFourBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day4WorkoutTitle ?? "", desc: package?.day4Workout ?? "")
    }
  
    @IBAction func workoutDayFiveBtn(_ sender: Any) {
        
        dynamicWorkButtonAction(title: package?.day5WorkoutTitle ?? "", desc: package?.day5Workout ?? "")
    }
    
    @IBAction func workoutDaySixBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day6WorkoutTitle ?? "", desc: package?.day6Workout ?? "")
    }
    @IBAction func workoutDaySevenBtn(_ sender: Any) {
        
        dynamicWorkButtonAction(title: package?.day7WorkoutTitle ?? "", desc: package?.day7Workout ?? "")
    }
    
    @IBAction func mealsDayOneBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day1MealsTitle ?? "", desc: package?.day1MeaksDescription ?? "")
    }
    
    @IBAction func mealsDayTwoBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day2MealsTitle ?? "", desc: package?.day2MeaksDescription ?? "")
    }
    
    @IBAction func mealsDayThreeBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day3MealsTitle ?? "", desc: package?.day3MeaksDescription ?? "")
    }
    
    @IBAction func mealsDayFourBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day4MealsTitle ?? "", desc: package?.day4MeaksDescription ?? "")
    }
    
    @IBAction func mealsDayFiveBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day5MealsTitle ?? "", desc: package?.day5MeaksDescription ?? "")
    }
    
    @IBAction func mealsDaySixBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day6MealsTitle ?? "", desc: package?.day6MeaksDescription ?? "")
    }
    
    @IBAction func mealsDaySevenBtn(_ sender: Any) {
        dynamicWorkButtonAction(title: package?.day7MealsTitle ?? "", desc: package?.day7MeaksDescription ?? "")
    }
}
